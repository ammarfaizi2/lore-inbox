Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261681AbREVNat>; Tue, 22 May 2001 09:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbREVNaj>; Tue, 22 May 2001 09:30:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17423 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261681AbREVNa2>; Tue, 22 May 2001 09:30:28 -0400
Subject: Re: [patch] s_maxbytes handling
To: andrewm@uow.edu.au (Andrew Morton)
Date: Tue, 22 May 2001 14:27:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3B0A6124.E90717E7@uow.edu.au> from "Andrew Morton" at May 22, 2001 10:52:52 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152CCP-0001rM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If ->f_pos is positioned exactly at sb->s_maxbytes, a non-zero-length
> write to the file doesn't write anything, and write() returns zero.

Are you absolutely sure here. Because I ran that code through a set of standards
verification tests. So unless you can cite page and paragraph from SuS and
the LFS spec I think the 0 might in fact be correct..

Alan



