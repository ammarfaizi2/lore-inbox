Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132698AbRDCVtq>; Tue, 3 Apr 2001 17:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132704AbRDCVth>; Tue, 3 Apr 2001 17:49:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29193 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132698AbRDCVtW>; Tue, 3 Apr 2001 17:49:22 -0400
Subject: Re: Minor 2.4.3 Adaptec Driver Problems
To: pochini@denise.shiny.it (Giuliano Pochini)
Date: Tue, 3 Apr 2001 22:50:44 +0100 (BST)
Cc: nietzel@yahoo.com (Earle Nietzel), linux-kernel@vger.kernel.org
In-Reply-To: <3AC8BEC7.CC5AA019@denise.shiny.it> from "Giuliano Pochini" at Apr 02, 2001 08:02:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kYhL-0000Ve-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I just got 2.4.3 up a running (on Abit BP6 Dual Celeron ) and
> > it reorderd my SCSI id's. Take a look. I don't like that my ZIP drive
> > becomes sda because if I ever remove it then I'll @#$% my harddrive dev
> > mappings again and have to change them again. Adaptec Driver 6.1.5
> > :-(
> 
> That's what ext2 volume labels are for.

Volume labels dont help for all cases. Its a bug in the 6.1.5 adaptec driver
which (to save Justin pointing it out) is fixed in 6.1.8
