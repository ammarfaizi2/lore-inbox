Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312281AbSCTXYv>; Wed, 20 Mar 2002 18:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312283AbSCTXYl>; Wed, 20 Mar 2002 18:24:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19217 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312281AbSCTXYZ>; Wed, 20 Mar 2002 18:24:25 -0500
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
To: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Mar 2002 23:39:15 +0000 (GMT)
Cc: Martin.Bligh@us.ibm.com (Martin J. Bligh),
        andrea@suse.de (Andrea Arcangeli), hugh@veritas.com (Hugh Dickins),
        riel@conectiva.com.br (Rik van Riel),
        dmccr@us.ibm.com (Dave McCracken),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20020320194549.A32457@infradead.org> from "Christoph Hellwig" at Mar 20, 2002 07:45:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16npfo-0003gA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That has been implemented in Caldera OpenUnix in the last years.

V7 unix had it. Thats where the "uarea" aka u. comes in. Its one of the
killer problems with Linux 8086 - on the 11 they could put the kernel stack
file handles and other process local crap into a swappable segment that
could also be swapped from the kernel address space. On the 8086 thats
trickier
