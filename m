Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266211AbUFUNU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUFUNU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUFUNU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:20:56 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9739 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266211AbUFUNUz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:20:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Hannu Savolainen <hannu@opensound.com>,
       Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: Stop the Linux kernel madness
Date: Mon, 21 Jun 2004 16:12:26 +0300
X-Mailer: KMail [version 1.4]
Cc: 4Front Technologies <dev@opensound.com>,
       David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <40D232AD.4020708@opensound.com> <1087802737.31390.3.camel@speedy.priv.grenoble.com> <Pine.LNX.4.58.0406211103200.26608@zeus.compusonic.fi>
In-Reply-To: <Pine.LNX.4.58.0406211103200.26608@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406211612.26366.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 June 2004 11:27, Hannu Savolainen wrote:
> On Mon, 21 Jun 2004, Xavier Bestel wrote:
> > Having more maintained drivers in the kernel can't be a bad thing. For a
> > standard desktop or server, having all these drivers installed
> > under /lib/modules is also beneficial.
>
> Having more drivers in the kernel is not bad. However having every
> possible driver there is stupid.
>
> A friend of mine created (years ago) an innovative oxygene analyzer for
> forest industry. They sold that to all possible factories in Finland and
> then got out of business because there were no more customers. What do all
> the millions of Linux users benefit if the driver for such device is
> included in the kernel? If Linux is really going to be the #1 operating
> system in the future then Linux drivers for this kind of devices will be
> quite common. In fact a large number of Linux kernel experts will work on
> this kind of projects. Isn't there any idea in making their life easier by
> dropping the silly idea that everything can be included in the kernel
> tree.

I don't think that number of Linux drivers will grow faster than
Net bandwodth, CPU speeds and disk capacity. So, in relative terms
downloading and compiling kernel tarballs will not become slower.

Keeping drivers in single place greatly improves chances of peer
review, bit rot prevention (think about fixes for newer GCC versions),
etc.
-- 
vda
