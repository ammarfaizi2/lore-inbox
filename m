Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130761AbRCEXVk>; Mon, 5 Mar 2001 18:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130759AbRCEXVa>; Mon, 5 Mar 2001 18:21:30 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:4107 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S130758AbRCEXVN>; Mon, 5 Mar 2001 18:21:13 -0500
Date: Mon, 5 Mar 2001 15:21:06 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <3AA41C3C.A8DE3254@mandrakesoft.com>
Message-ID: <Pine.LNX.4.31ksi3.0103051514050.12620-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Jeff Garzik wrote:

> Amazingly you've hit one of the few problems caused by something
> outside
> the kernel tree.  db v1.85 has been superceded by db2 and db3.  db1 is
> where the "original" Berkeley db stuff now lives.  Apparently aicasm
> needs db 1.
>
> So, update your packages, or create the proper symlinks if you've
> already got db1 installed in some other location.

I _DO_ know what db1 stands for. And we do _NOT_ have db1 in our
distribution, KSI Linux. And we are _NOT_ going to build the obsolete
library with all the accompanied development stuff just to be able to make
some tool required to build exactly ONE kernel driver. It was a nightmare to
get rid of TREE incompatible libdbs so it doesn't make any sence to get that
mess back in. It's just plain braindead to do something like this. Occam was
right and this is plain stupid.

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

