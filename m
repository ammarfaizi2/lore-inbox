Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbULQPLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbULQPLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 10:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbULQPLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 10:11:20 -0500
Received: from news.suse.de ([195.135.220.2]:51622 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261254AbULQPLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 10:11:17 -0500
Date: Fri, 17 Dec 2004 16:11:15 +0100
From: Andi Kleen <ak@suse.de>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       elsa-announce <elsa-announce@lists.sourceforge.net>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [RFC] fork historic module
Message-ID: <20041217151115.GD14229@wotan.suse.de>
References: <1103295512.7329.75.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103295512.7329.75.camel@frecb000711.frec.bull.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* IOCTL numbers */
> +/* If you add a new IOCTL number don't forget to update FH_MAXNR */
> +#define FH_MAGIC	0x35
> +#define FH_REGISTER	_IO(FH_MAGIC,0)
> +#define FH_UNREGISTER	_IO(FH_MAGIC,1)

Is this really unique? 32bit emulation currently needs unique ioctl numbers.

-Andi
