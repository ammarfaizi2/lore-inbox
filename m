Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264553AbTCZCHj>; Tue, 25 Mar 2003 21:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264554AbTCZCHj>; Tue, 25 Mar 2003 21:07:39 -0500
Received: from pc2-bahd1-3-cust72.renf.cable.ntl.com ([62.255.161.72]:50271
	"EHLO localhost") by vger.kernel.org with ESMTP id <S264553AbTCZCHi>;
	Tue, 25 Mar 2003 21:07:38 -0500
Date: Wed, 26 Mar 2003 02:18:47 +0000
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: addition to visor.c
Message-ID: <20030326021847.GA21363@localhost>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.4.20 (i686)
X-Uptime: 01:31:51 up  2:47,  4 users,  load average: 1.31, 1.18, 0.67
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, hi all and thanks for all the kernels. :D

I have fiddled together the following info for a sony clie nz90, which i
believe should go in drivers/usb/serial/visor.{h,c}.

in visor.h:

#define SONY_CLIE_NZ90_ID		0x00E9

and in visor.c:

{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_NZ90_ID) },

in two places, both after the line

{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_4_1_ID) },

this is almost definitely an awful way of submitting these, but this is
my first ever attempt at kernel hacking (and it barely counts as such
(and it barely counts as something that barely counts...)) so please
don't flame me too hard.

it just compiled, and assuming it boots && recognizes the device, i'll
send this.

ok, it recognizes, but none of the apps i have seem to like the clie - i
get 'please press hotsync button now' messages, despite the fact that
the /dev/ttyUSB1 device is only there after the button has been
pressed... :(

my sister's clie cries out for breakout, and an internet...

cheers,

iain
(scared and tired and wanting to PLAY WITH MY SISTER'S NEW CLIE DAMMIT
:p)

PS: please CC: me on replies, i'm subscribed but have a tendency to not
spot list replies. thanks.

-- 
wh33, y1p33 3tc.
