Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262445AbRFLQS4>; Tue, 12 Jun 2001 12:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbRFLQSu>; Tue, 12 Jun 2001 12:18:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19722 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262445AbRFLQSg>; Tue, 12 Jun 2001 12:18:36 -0400
Subject: Re: [PATCH] megaraid.c
To: praveens@stanford.edu (Praveen Srinivasan)
Date: Tue, 12 Jun 2001 17:17:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <200106120605.f5C65f402129@smtp1.Stanford.EDU> from "Praveen Srinivasan" at Jun 11, 2001 11:05:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159qqi-0001Z4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes an instance where an allocation is checked, but only after 
> the pointer is memset() - moving the memset further down in the function 
>

Linus - please skip this one. There is a newer (1.15d) megaraid driver ready
to go on to you this weekend and it fixes this, pci api usage and security 
holes

