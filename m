Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbREHJgB>; Tue, 8 May 2001 05:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbREHJfw>; Tue, 8 May 2001 05:35:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33035 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130507AbREHJfl>; Tue, 8 May 2001 05:35:41 -0400
Subject: Re: [Question] Explanation of zero-copy networking
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Mon, 7 May 2001 22:59:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), alexander.eichhorn@rz.tu-ilmenau.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105071106470.10009-100000@twinlark.arctic.org> from "dean gaudet" at May 07, 2001 11:21:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wt2p-00048d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so there's still single copy for write() of a mmap()ed page?

An mmap page will go direct to disk. But mmap() isnt a good model for 
streaming I/O.

> 
> 

