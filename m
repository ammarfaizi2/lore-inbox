Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVFALbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFALbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFALbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:31:41 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:9095 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261318AbVFALbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:31:34 -0400
Date: Wed, 1 Jun 2005 13:31:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: coywolf@lovecn.org
Cc: David Woodhouse <dwmw2@infradead.org>, Carsten Otte <cotte@freenet.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 0/5] add execute in place support
Message-ID: <20050601113104.GA29116@wohnheim.fh-wedel.de>
References: <428216DF.8070205@de.ibm.com> <1115828389.16187.544.camel@hades.cambridge.redhat.com> <42823450.8030007@freenet.de> <20050512085741.GA16361@wohnheim.fh-wedel.de> <1115890981.16187.553.camel@hades.cambridge.redhat.com> <2cd57c90050601023358417bbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cd57c90050601023358417bbd@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 June 2005 17:33:29 +0800, Coywolf Qi Hunt wrote:
> On 5/12/05, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Thu, 2005-05-12 at 10:57 +0200, Jörn Engel wrote:
> > > In principle, both the block device abstraction and the mtd
> > > abstraction fit your bill.  But jffs2 doesn't, so no in-kernel fs
> > > could make use of a xip-aware mtd abstraction.
> > >
> > > Patching jffs2 for xip looks like a major effort, at best, and utterly
> > > insane at worst.  I'd prefer not to go down that path.
> > 
> > You and me both. The time has definitely come to recognise that JFFS2
> > needs replacing ;)
> 
> I'd say yaffs seems to be a good one. 

Not if you care about XIP.  Yaffs won't run on NOR flashes and XIP
won't work on NAND.

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
