Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWHNRKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWHNRKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWHNRKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:10:20 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:8945 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932372AbWHNRKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:10:19 -0400
Date: Mon, 14 Aug 2006 19:09:59 +0200
From: Voluspa <lista1@comhem.se>
To: lukesharkey@hotmail.co.uk
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
       gene.heskett@verizon.net, ian.stirling@mauve.plus.com, davej@redhat.com,
       andi@rhlx01.fht-esslingen.de, malattia@linux.it
Subject: Re: Touchpad problems with latest kernels
Message-Id: <20060814190959.df449d55.lista1@comhem.se>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-08-14 13:58:09 Luke Sharkey wrote:
> While on 2054 it generally works fine, On the latest kernels (2154,
> 2174 etc.)  I have only to e.g. open a konqueror window for the
> onscreen pointer to start going funny, and jerking about (As happens on
> computers with v. low RAM).  I know its not a RAM problem, as a)
> everything else works fine, there is no slow down of any of the
> programs I run, only problems with the mouse and b) I have just
> upgraded from 512 MB of RAM to 1 GB.
>
> If I plug in a mouse, the pointer works fine.  Though I would happily
> use a mouse, this is often inconvenient on a laptop.
>
> Do you have any ideas what's wrong?

This is a known problem (and fixed in Windows) with the synaptics touch
pad. About one year ago I did a web search amounting to something like
"synaptics rubber band" and found a fixed windows driver. But since
there is no OS of that kind on this machine, I contacted the developer
of the synaptics X driver.

We had a discussion (swedish only) in private mail, where I ran the
driver in debug mode - he no longer had a machine with that hardware.
Unfortunately I've lost the whole communication due to a voltage frying
of everything in the mail machine, so can not give any details.

If Peter Österlund still has the e-mails I hereby give full permission
to disclose a translated copy to anyone interested.

But I think it all came down to Peter not being able to do anything...
In earlier kernels the issue _seemed_ to lessen if booting with
i8042.nomux but nowadays that kernel option only gets rid of the 'lost
sync' messages from the pad that turn up in /var/log/messages
(Btw, excessive printing of that message Dmitry!)

Mvh
Mats Johannesson
