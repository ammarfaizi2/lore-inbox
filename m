Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbREXO3r>; Thu, 24 May 2001 10:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbREXO3h>; Thu, 24 May 2001 10:29:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24595 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262036AbREXO32>; Thu, 24 May 2001 10:29:28 -0400
Subject: Re: [PATCH] bulkmem.c - null ptr fixes for 2.4.4
To: praveens@stanford.edu (Praveen Srinivasan)
Date: Thu, 24 May 2001 15:26:20 +0100 (BST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, dhinds@zen.stanford.edu
In-Reply-To: <200105240723.f4O7NG403563@smtp1.Stanford.EDU> from "Praveen Srinivasan" at May 24, 2001 12:24:21 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152w4C-00052g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel code. This patch fixes numerous unchecked pointers in the PCMCIA 
> bulkmem driver. 

Since when has two been numerous - also I dont thin the fix is right - you need
to undo what has already been done
