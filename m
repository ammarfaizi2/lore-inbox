Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314439AbSD0Txu>; Sat, 27 Apr 2002 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314442AbSD0Txt>; Sat, 27 Apr 2002 15:53:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50962 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314439AbSD0Txt>; Sat, 27 Apr 2002 15:53:49 -0400
Subject: Re: [PATCH] (repost) kmem_cache_zalloc
To: hch@infradead.org (Christoph Hellwig)
Date: Sat, 27 Apr 2002 21:11:48 +0100 (BST)
Cc: sandeen@sgi.com (Eric Sandeen), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, marcelo@conectiva.com.br
In-Reply-To: <20020425094143.A17406@infradead.org> from "Christoph Hellwig" at Apr 25, 2002 09:41:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171YXs-0000e9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> caches, and a memset directly after the alloc destroys the object state.
> A kmen_zalloc/kzalloc might make more sense.

s/kzalloc/kcalloc/

Then our api continues to remind people of the C one so is easier to 
remember (and we need calloc stuff anyway in multiple places)
