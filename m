Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317567AbSGEUqe>; Fri, 5 Jul 2002 16:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317568AbSGEUqd>; Fri, 5 Jul 2002 16:46:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13060 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317567AbSGEUqc>; Fri, 5 Jul 2002 16:46:32 -0400
Subject: Re: StackPages errors (CALLTRACE)
To: jalvo@mbay.net (John Alvord)
Date: Fri, 5 Jul 2002 22:12:08 +0100 (BST)
Cc: thunder@ngforever.de (Thunder from the hill),
       exilion@yifan.net (Pablo Fischer), hahn@physics.mcmaster.ca (Mark Hahn),
       linux-kernel@vger.kernel.org
In-Reply-To: <83ubiu433pkcf41ev9ihl7mgo0tn1kokcc@4ax.com> from "John Alvord" at Jul 05, 2002 12:50:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17QaN6-0004Ci-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There has also been a patch on L-K which implments CMOV on prior-PPro
> processors. john

It has a hideous overhead. Just dont use cmov blindly in kernels. The kernel 
stuff will take care not to let the compiler stick cmov instructions into
a non ppro+ kernel
