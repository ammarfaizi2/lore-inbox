Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbUL2Jvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbUL2Jvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 04:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbUL2Jvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 04:51:50 -0500
Received: from levante.wiggy.net ([195.85.225.139]:12233 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261337AbUL2Jvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 04:51:35 -0500
Date: Wed, 29 Dec 2004 10:51:30 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c
Message-ID: <20041229095129.GI24603@wiggy.net>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
	samba-technical <samba-technical@lists.samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost> <1104104286.16545.7.camel@localhost.localdomain> <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost> <20041229015716.GB29323@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041229015716.GB29323@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jörn Engel wrote:
> On Wed, 29 December 2004 00:52:32 +0100, Jesper Juhl wrote:
> > -static int cifs_relock_file(struct cifsFileInfo * cifsFile)
> > +static int 
> > +cifs_relock_file(struct cifsFileInfo *cifsFile)
> 
> Linus viciously prefers to keep return type and function name on a
> single line.  I cannot quite follow his reasoning, but would leave
> that part out, unless explicitly requested by Steve.

If they are on a single line grep will find the return type as well
which is extremely convenient.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
