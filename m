Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274197AbRISVr7>; Wed, 19 Sep 2001 17:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272718AbRISVrt>; Wed, 19 Sep 2001 17:47:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35845 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274199AbRISVrh>; Wed, 19 Sep 2001 17:47:37 -0400
Subject: Re: Request: removal of fs/fs.h/super_block.u to enable partition
To: swansma@yahoo.com (Mark Swanson)
Date: Wed, 19 Sep 2001 22:52:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3BA8F6EC.E3D73C87@yahoo.com> from "Mark Swanson" at Sep 19, 2001 03:50:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jpH2-0003wz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You are not going to stop a tired sysadmin doing something daft. You can
> > certainly create a GPL'd raw partition as a file fs (I believe someone did
> > that so INN could mmap raw on a device)
> > 
> > However you don't need to remove anything for that
> 
> But I can't distribute the file fs with my application,
> because I can't expect my
> user base to patch and recompile their kernel just so they can run
> my application.
> 
> Perhaps what is needed is an 'inuse' filesystem or a way to make 
> filesystem modules without patching the kernel. 

Apart from the fact that the interface is source level you already can
distribute, compile and merge file systems without patching the kernel.

It seems to be a user space issue not a kernel one. Your app can amend
/etc/mtab when it creates and shuts down. 

Alan
