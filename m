Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUL0Bbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUL0Bbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUL0Bbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:31:43 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:21693 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261627AbUL0Bbl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:31:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Ho ho ho - Linux v2.6.10
Date: Sun, 26 Dec 2004 20:31:38 -0500
User-Agent: KMail/1.6.2
Cc: Greg Norris <haphazard@kc.rr.com>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <20041226203517.GA4081@yggdrasil.localdomain>
In-Reply-To: <20041226203517.GA4081@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412262031.39066.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 03:35 pm, Greg Norris wrote:
> On Fri, Dec 24, 2004 at 02:39:09PM -0800, Linus Torvalds wrote:
> > Ok, with a lot of people taking an xmas break, here's something to play
> > with over the holidays (not to mention an excuse for me to get into the
> > Glögg for real ;)
> 
> My ps/2 keyboard (an relatively uninteresting Labtec 104-key model)
> doesn't work with 2.6.10, although 2.6.9 and the BIOS seem to have no 
> issues with it.  I've gone through the changelog and double-checked my 
> .config (attached), and don't see any obvious problems... any thoughts?
> 
> 

Anything interesting in dmesg? And what about mouse? You may have to change
#undef DEBUG to #define DEBUG in drivers/input/serio/i8042.c and post your
full dmesg.
 
-- 
Dmitry
