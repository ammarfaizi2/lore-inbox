Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTIIRlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTIIRlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:41:46 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:14977 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S264338AbTIIRlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:41:44 -0400
Subject: Re: New ATI FireGL driver supports 2.6 kernel
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dennis Freise <Cataclysm@final-frontier.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030909075023.GA8065@redhat.com>
References: <001a01c3765b$1f1ad6e0$0419a8c0@firestarter.shnet.org>
	 <20030908225401.GD681@redhat.com>
	 <1063069344.28622.53.camel@dhcp23.swansea.linux.org.uk>
	 <20030909075023.GA8065@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063129307.777.8.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 20:41:47 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-09 at 10:50, Dave Jones wrote:
> On Tue, Sep 09, 2003 at 02:02:25AM +0100, Alan Cox wrote:
> 
>  > > Linking GPL code to binary .o files, and then disabling the
>  > > MODULE_LICENSE("GPL") smells pretty fishy to me.
>  > 
>  > If all the code they include is their own then they could have dual
>  > licensed it. If not and they are modifying core kernel code to add hooks
>  > for their code they aren't likely to get past the preliminary arguments 
>  > about a GPL violation and it being a derivative work.
> 
> For one it links in the GPL'd nvidia GART module.

Hmm, dunno about that:

$ grep -i license nvidia-agp.c
MODULE_LICENSE("GPL and additional rights");

All the rest seems to be under a BSD style license.

	MikaL

