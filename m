Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRDAUWE>; Sun, 1 Apr 2001 16:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRDAUVy>; Sun, 1 Apr 2001 16:21:54 -0400
Received: from isunix.it.ilstu.edu ([138.87.124.103]:54034 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S132548AbRDAUVk>; Sun, 1 Apr 2001 16:21:40 -0400
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200104012028.PAA05467@isunix.it.ilstu.edu>
Subject: Re: how mmap() works?
To: andreas.bombe@munich.netsurf.de (Andreas Bombe)
Date: Sun, 1 Apr 2001 15:28:05 -0500 (CDT)
Cc: jhong001@yahoo.com (Jerry Hong), linux-kernel@vger.kernel.org
In-Reply-To: <20010401184131.A2474@storm.local> from "Andreas Bombe" at Apr 01, 2001 06:41:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Without syncing, Linux writes whenever it thinks it's appropriate, e.g.
> when pages have to be freed (I think also when the bdflush writes back
> data, i.e. every 30 seconds by default).

what about mmap() on non-filesystem files (/dev/mem, /proc/bus/pci...) ?

