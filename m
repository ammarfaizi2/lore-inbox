Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274142AbRISTXo>; Wed, 19 Sep 2001 15:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274143AbRISTXf>; Wed, 19 Sep 2001 15:23:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12563 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274142AbRISTX2>; Wed, 19 Sep 2001 15:23:28 -0400
Subject: Re: Request: removal of fs/fs.h/super_block.u to enable partition locking
To: swansma@yahoo.com (Mark Swanson)
Date: Wed, 19 Sep 2001 20:28:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA7FF92.D6477904@yahoo.com> from "Mark Swanson" at Sep 18, 2001 10:14:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jn1X-0003cU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to look out for tired sys-admins who might 
> destroy my application's partition not knowing
> what a particular empty-looking partition is used for.

You are not going to stop a tired sysadmin doing something daft. You can
certainly create a GPL'd raw partition as a file fs (I believe someone did
that so INN could mmap raw on a device)

However you don't need to remove anything for that
