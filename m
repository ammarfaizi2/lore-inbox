Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289074AbSAIX2z>; Wed, 9 Jan 2002 18:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289075AbSAIX2j>; Wed, 9 Jan 2002 18:28:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19978 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289074AbSAIX2O>; Wed, 9 Jan 2002 18:28:14 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Date: 9 Jan 2002 15:28:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1ijm9$hcl$1@cesium.transmeta.com>
In-Reply-To: <20020109154742.B28755@thyrsus.com> <Pine.LNX.4.33.0201092238100.29914-100000@sphinx.mythic-beasts.com> <20020109174637.A1742@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020109174637.A1742@thyrsus.com>
By author:    "Eric S. Raymond" <esr@thyrsus.com>
In newsgroup: linux.dev.kernel
>
> Matthew Kirkwood <matthew@hairy.beasts.org>:
> > > The underlying problem is that dmidecode needs access to kmem, and I
> > > can't assume that the person running my configurator will be root.
> > 
> > But you can "su -c" (also sudo, I suppose).  If that person
> > doesn't have root, then building a kernel isn't going to do
> > them much good.
> 
> We've been over this already.  No, the configurator user should *not* have
> to su at any point before actual kernel installation.  Bad practice, 
> no doughnut.
> 

We have also been over the fact that dmidecode, if written
appropriately, could be setuid, or call a "dmicat" setuid program.
This is a dmidecode implementation detail.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
