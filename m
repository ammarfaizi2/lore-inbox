Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265974AbSKZN5L>; Tue, 26 Nov 2002 08:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbSKZN5L>; Tue, 26 Nov 2002 08:57:11 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:37265 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265974AbSKZN5K>; Tue, 26 Nov 2002 08:57:10 -0500
Subject: Re: [PATCH] ncpfs seems to need the timer init
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021126135322.GA30362@vana>
References: <200211260411.gAQ4BUo24135@hera.kernel.org> 
	<20021126135322.GA30362@vana>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 14:35:24 +0000
Message-Id: <1038321324.2594.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 13:53, Petr Vandrovec wrote:
> On Tue, Nov 26, 2002 at 02:12:52AM +0000, Linux Kernel Mailing List wrote:
> 
> Linus, please revert this. It is changeset 
> 
> alan@lxorguk.ukuu.org.uk|ChangeSet|20021126021252|43411
> 
> Timer is already initialized few lines above in the code. If you'll look
> through fs/ncpfs/inode.c history, you'll find that I already asked once
> for removing this redundant timer initialization, but unfortunately it
> found its way to the tree again :-(

Sorry. I'll revert that in my tree too

