Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbSIQXlu>; Tue, 17 Sep 2002 19:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264698AbSIQXlu>; Tue, 17 Sep 2002 19:41:50 -0400
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:264 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S264689AbSIQXls>;
	Tue, 17 Sep 2002 19:41:48 -0400
Subject: Re: [Linux-usb-users] Re: Problems accessing USB Mass Storage
From: Mark C <gen-lists@blueyonder.co.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Thomas Dodd <ted@cypress.com>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-usb-users <linux-usb-users@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0209171627330.14033-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0209171627330.14033-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 18 Sep 2002 00:46:48 +0100
Message-Id: <1032306409.1141.28.camel@stimpy.angelnet.internal>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 00:29, Randy.Dunlap wrote:
> On 18 Sep 2002, Mark C wrote:
> 
> | On Wed, 2002-09-18 at 00:09, Randy.Dunlap wrote:
> |
> | > Have you tried Rogier's 'seek' program yet?
> |
> | Yes, but I think I'm getting the whole syntax wrong.
> 
> maybe so.  he had (...) parens around the command and you don't.
> the parens are important there.

Running:
[root@stimpy mark]# (seek 0x100000;dd of=secondpart) < /dev/sda
dd: reading `standard input': Input/output error
0+0 records in
0+0 records out


Heres the dmesg output:

 I/O error: dev 08:00, sector 2048
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage: 1e 00 00 00 00 00 12 c0 70 ca 86 c4
usb-storage: Bulk command S 0x43425355 T 0x5b Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x5b R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.

I think This is really taking up too many peoples personal time now,
So I'm going to purchase a Smart card reader and try to use that instead
(yes One I know Linux supports :-)).

I decided at the start if this week, to learn C, now I have a goal, I'm
going to get this camera working, if its the last thing I do (is its
possible at all).

Along the way I should gain a whole lot more knowledge into how the
kernel interacts with devices ( yes I know there is a lot to learn
before I start playing around with writing drivers, but this a target to
head for)

Once again I would like to thank everybody for the time and effort they
have put into this, Its really appreciated.

I anyone feels I'm just dropping this and wishes to get this cracked,
them I will be more than willing to carry on trying.

Cheers

Mark
 

-- 
---
To steal ideas from one person is plagiarism;
to steal from many is research.

