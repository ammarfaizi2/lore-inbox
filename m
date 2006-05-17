Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWEQBdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWEQBdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWEQBdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:33:54 -0400
Received: from e-nvb.com ([69.27.17.200]:36483 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S1750759AbWEQBdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:33:54 -0400
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060516122731.6ecbdeeb.akpm@osdl.org>
References: <20060516174413.GI10077@stusta.de>
	 <20060516122731.6ecbdeeb.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 03:33:11 +0200
Message-Id: <1147829611.3051.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 12:27 -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > - remove the following unused EXPORT_SYMBOL's:
> >   - journal_set_features
> >   - journal_update_superblock
> 
> These might be used by lustre - dunno.
> 
> But I'm ducking all patches which alter exports, as usual.  If you can get
> them through the subsystem maintainer then good luck.
> 
> I'd suggest that we pursue the approach of getting the module loader to
> spit a warning when someone uses a going-away-soon export.
> 
> Arjan had a patch which did that, but he removed basically _every_
> presently-unused export.  

NOT IN THE SAME PATCH!
I made the infrastructure a very nicely separate patch.... and I thought
I explained that to you as well ;(


