Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSL2Wn0>; Sun, 29 Dec 2002 17:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSL2Wn0>; Sun, 29 Dec 2002 17:43:26 -0500
Received: from host194.steeleye.com ([66.206.164.34]:13837 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261398AbSL2Wn0>; Sun, 29 Dec 2002 17:43:26 -0500
Message-Id: <200212292251.gBTMpim12460@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Christoph Hellwig <hch@lst.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove CONFIG_X86_NUMA 
In-Reply-To: Message from Christoph Hellwig <hch@lst.de> 
   of "Sun, 29 Dec 2002 23:40:51 +0100." <20021229234051.A12535@lst.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Dec 2002 16:51:44 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch@lst.de said:
> I already wondered about that, but AFAIK a kernel with X86_NUMAQ set
> still boots on a PeeCee, so it's really an option, not a choice.

It alters the mflags-y and mcore-y variables in arch/i386/Makefile, so it's 
one of the subarch choices and thus should really be under the menu options.

James


