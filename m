Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273816AbRIRDKe>; Mon, 17 Sep 2001 23:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273817AbRIRDK0>; Mon, 17 Sep 2001 23:10:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48914 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273816AbRIRDKP>; Mon, 17 Sep 2001 23:10:15 -0400
Subject: Re: Linux 2.4.10-pre11
To: tomlins@cam.org (Ed Tomlinson)
Date: Tue, 18 Sep 2001 04:15:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org> from "Ed Tomlinson" at Sep 17, 2001 11:18:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jBLy-0008UF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are fast.  Was just going report this one...
> Using debian sid with gcc 2.95.4.  Both before and after
> appling the patch below I get:

You need gcc 2.96 or higher to build the pre11 tree. I doubt that was
intentional. Basically rip out all use of __builtin_expect


Alan
