Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVBYIrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVBYIrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 03:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVBYIrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 03:47:05 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:29025 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262653AbVBYIrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 03:47:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TXDX8YYJ8ZpUHCdjxmib7hAYAClXv8PwNjpj6di02UJ+NEhz+RCVnSvvmT7VIXmTjTQVDPGjAALZ31vAhTYM8AcXlzz8u2fZTYWBlpMVcgEEDVX4V8Ta9PiPfjbNzuGS2buCwPB9cqs2N8VOKzua/fFiQDnKKAHoZ3TtFae8Eeg=
Message-ID: <58cb370e050225004759e1dc59@mail.gmail.com>
Date: Fri, 25 Feb 2005 09:47:01 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] unexport do_settimeofday
Cc: Arjan van de Ven <arjan@infradead.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050225002804.4905b649.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050224233742.GR8651@stusta.de>
	 <20050224212448.367af4be.akpm@osdl.org>
	 <1109318525.6290.32.camel@laptopd505.fenrus.org>
	 <20050225002804.4905b649.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2005 00:28:04 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > On Thu, 2005-02-24 at 21:24 -0800, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > >
> > > >  I haven't found any possible modular usage of do_settimeofday in the
> > > >  kernel.
> > >
> > > Please,
> > >
> > > - Add deprecated_if_module
> > >
> > > - Use it for do_settimeofday()
> > >
> > > - Add do_settimeofday to Documentation/feature-removal-schedule.txt
> > > -
> >
> > for _set_ time of day? I really can't imagine anyone messing with that.
> > _get_... sure. but set???
> 
> Sure.  But there must have been a reason to export it in the first place.

sloppy coding?
