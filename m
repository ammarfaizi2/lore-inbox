Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310436AbSCBUPq>; Sat, 2 Mar 2002 15:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310437AbSCBUPg>; Sat, 2 Mar 2002 15:15:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310436AbSCBUPW>; Sat, 2 Mar 2002 15:15:22 -0500
Subject: Re: kernel thread --> user process
To: jhollingsworth@elon.edu (Joel Hollingsworth)
Date: Sat, 2 Mar 2002 20:30:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1015099588.24535.175.camel@trumpy.elon.edu> from "Joel Hollingsworth" at Mar 02, 2002 03:06:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hG9A-0008Li-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the use of execve. The kernel thread is started from a loadable 
> module - so there has been no user-level process dipping into the 
> kernel that we could just replace. 

Take a look at how the module loader code works - it does precisely
what you need
