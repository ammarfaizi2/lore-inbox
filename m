Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSGVLB7>; Mon, 22 Jul 2002 07:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSGVLAh>; Mon, 22 Jul 2002 07:00:37 -0400
Received: from verein.lst.de ([212.34.181.86]:18186 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S316739AbSGVK7w>;
	Mon, 22 Jul 2002 06:59:52 -0400
Date: Mon, 22 Jul 2002 13:02:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: martin@dalecki.de
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 sysctl
Message-ID: <20020722130257.A16919@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, martin@dalecki.de,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE17F.3040905@evision.ag> <20020722125347.B16685@lst.de> <3D3BE4C7.2060203@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D3BE4C7.2060203@evision.ag>; from dalecki@evision.ag on Mon, Jul 22, 2002 at 12:56:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:56:07PM +0200, Marcin Dalecki wrote:
> > Please don't remove the trailing commas in the enums.  they make adding
> > to them much easier and are allowed by gcc (and maybe C99, I'm not
> > sure).
> 
> It's an GNU-ism.

So what?

The kernel is full of GNUisms, and this one is actually usefull.

> If you have any problem with "adding vales", just
> invent some dummy end-value. I have a problem with using -pedantic.

-pedantic barfs on named initializers, so you have to remove them first.
