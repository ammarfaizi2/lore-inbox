Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSGAQBJ>; Mon, 1 Jul 2002 12:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSGAQBI>; Mon, 1 Jul 2002 12:01:08 -0400
Received: from [62.70.58.70] ([62.70.58.70]:12935 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315709AbSGAQBH> convert rfc822-to-8bit;
	Mon, 1 Jul 2002 12:01:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: lilo/raid?
Date: Mon, 1 Jul 2002 18:02:28 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020701115130.23428A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020701115130.23428A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207011802.28264.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 July 2002 17:52, Bill Davidsen wrote:
> On Mon, 1 Jul 2002, Roy Sigurd Karlsbakk wrote:
> > still - sorry if this is OT - I'm just too close to tear my hair or head
> > off or something
> >
> > The documentation everywhere, including the lilo 22.3.1 sample conf ffile
> > tells me "use boot = /dev/md0", but lilo, when run, just tells me
> >
> > Fatal: Filesystem would be destroyed by LILO boot sector: /dev/md0
>
> I saw something like that when someone had made a raid device by hand and
> used hda and hdb instead of hda1 and hdb1.

problem is: lilo does not seem to install at all with hd[ab]1 given. only 
hdm(!!!), and then it just goes LI

See dmesg log at http://karlsbakk.net/bugs/ for more info

thanks for all help

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

