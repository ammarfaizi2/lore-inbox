Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTHaTAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 15:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTHaTAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 15:00:14 -0400
Received: from mail.mediaways.net ([193.189.224.113]:54008 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S261586AbTHaTAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 15:00:10 -0400
Subject: Re: Freeze with HPT370 2.4.22-rc2 and dxr3
From: Soeren Sonnenburg <kernel@nn7.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.55L.0308301721390.31768@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0308301721390.31768@freak.distro.conectiva>
Content-Type: text/plain
Message-Id: <1062356267.11436.218.camel@localhost>
Mime-Version: 1.0
Date: Sun, 31 Aug 2003 20:57:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-30 at 22:25, Marcelo Tosatti wrote:
> > When I play a movie through the dxr3 (driver form dxr3.sf.net) it used
> > to work just fine for quite a long time.
> > However now that I use a software raid (one via ide on asus a7v8x and 2
> > hpt370) I can reproducably get the system to freeze when I mplayer -vo
> > dxr3 <file_on_sw_raid> after less than 10 minutes.
> 
> > Then the IDE lid is continuously on until I reset the machine.
> 
> > I found out that when I copy the file to a ram disk and then play it
> > through dxr3 it works just fine (no freeze). This happens even when I
> > boot with init=/bin/sh (so no nvidia or other binary only modules).
> 
> > Any ideas on what to try out ?
> 
> Does the same happen with 2.4.20 or 2.4.21? (try with no binary modules
> please)

Yes, happens with 2.4.21 and no binary modules. Shall I also try out
2.4.20 ? I will if needed and it works with ide >137G / via chipset in
udma mode.

Regards,
Soeren.

