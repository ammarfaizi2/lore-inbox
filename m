Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbRF1L6Z>; Thu, 28 Jun 2001 07:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265642AbRF1L6P>; Thu, 28 Jun 2001 07:58:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19211 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265641AbRF1L56>; Thu, 28 Jun 2001 07:57:58 -0400
Subject: Re: problem building 2.4.6 pre 6 + freevxfs
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Thu, 28 Jun 2001 12:57:16 +0100 (BST)
Cc: gp@iws.it (Giampaolo Gallo), linux-kernel@vger.kernel.org
In-Reply-To: <200106280909.f5S99Bd24719@ns.caldera.de> from "Christoph Hellwig" at Jun 28, 2001 11:09:12 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FaQ8-0006mb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > function)
> > vxfs_inode.c:50: initializer element is not constant
> > vxfs_inode.c:50: (near initialization for `vxfs_file_operations.llseek')
> 
> Just remove the complete line - generic_file_llseek doesn't exist in
> 2.4.6-pre6 and it's appeareance seems to be an merge error.

Arghhh my fault. I thought I'd sent Linus generic_file_llseek - apologies
I'll fix that one

