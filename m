Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271949AbRHVKVu>; Wed, 22 Aug 2001 06:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271950AbRHVKVk>; Wed, 22 Aug 2001 06:21:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55819 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271949AbRHVKVd>; Wed, 22 Aug 2001 06:21:33 -0400
Subject: Re: 2.4.9 kernel i810 module Initialization problem
To: yknot@cipic.ucdavis.edu (Dennis Thompson)
Date: Wed, 22 Aug 2001 11:24:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Dennis Thompson" at Aug 21, 2001 09:58:03 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZVBe-0001H0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I was using the i810 module for APG video (2.4.7 kernel) with no problems. 
> After installation of the 2.4.9 kernel the module failed to initialize. 

Linus updated the kernel supporting code for direct rendering to require
XFree 4.1. If you want to use a current kernel with the older XFree 4.0.x
then pick up the 2.4.8-ac tree instead, and use the DRM 4.0 option
