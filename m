Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTDWPo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTDWPo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:44:57 -0400
Received: from imap.gmx.net ([213.165.65.60]:28542 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264087AbTDWPo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:44:29 -0400
Date: Wed, 23 Apr 2003 17:56:29 +0200
From: gigerstyle@gmx.ch
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030423175629.7cfc9087.gigerstyle@gmx.ch>
In-Reply-To: <20030423144705.GA2823@elf.ucw.cz>
References: <20030423135100.GA320@elf.ucw.cz>
	<Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be>
	<20030423144705.GA2823@elf.ucw.cz>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Just a quick question:

As I know, swsusp is for hybernation (S4), right? The memory content will be written to the swap partition. What happens if the swap space is already used from programs? Abort? Or do I have to reserve swap space which never has to be used from programs?

Thank you!

Marc


On Wed, 23 Apr 2003 16:47:05 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > Swsusp without swap makes no sense, but leads to compilation
> > > failure. This fixes it. Please apply,
> > 
> > Just wondering, what about MMU-less machines?
> 
> Ugh... Currently: no we can't do that. We are happy to suspend/resume
> on i386 ;-).
> 								Pavel
