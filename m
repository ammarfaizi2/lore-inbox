Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281306AbRKUIlj>; Wed, 21 Nov 2001 03:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281327AbRKUIla>; Wed, 21 Nov 2001 03:41:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48396 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281306AbRKUIlS>; Wed, 21 Nov 2001 03:41:18 -0500
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Wed, 21 Nov 2001 08:49:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: <20011121001639.A813@vger.timpanogas.org> from "Jeff V. Merkey" at Nov 21, 2001 12:16:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E166T4K-0004Lr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's really strange one.  Building a module against 2.4.15-pre7 
> seems to generate invalid opcodes (???) from the kernel includes.

You hit a BUG(). If you rebuild the kernel with verbose BUG reporting 
included you'll get a line and file to work back from
