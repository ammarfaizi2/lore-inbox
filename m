Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267652AbSLFWod>; Fri, 6 Dec 2002 17:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267653AbSLFWod>; Fri, 6 Dec 2002 17:44:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12777 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267652AbSLFWoc>;
	Fri, 6 Dec 2002 17:44:32 -0500
Date: Fri, 06 Dec 2002 14:49:01 -0800 (PST)
Message-Id: <20021206.144901.48134923.davem@redhat.com>
To: James.Bottomley@steeleye.com
Cc: adam@yggdrasil.com, willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200212062248.gB6Mmvh04649@localhost.localdomain>
References: <davem@redhat.com>
	<200212062248.gB6Mmvh04649@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@steeleye.com>
   Date: Fri, 06 Dec 2002 16:48:57 -0600

   I just don't like API names that look like
   
   dma_alloc_may_be_inconsistent()
   
   but if that's what it takes, I'll do it

Just use dma_alloc_noncoherent() and we can grep for that.
