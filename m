Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSGWJut>; Tue, 23 Jul 2002 05:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSGWJut>; Tue, 23 Jul 2002 05:50:49 -0400
Received: from [202.145.83.35] ([202.145.83.35]:32271 "EHLO ite.techarea.org")
	by vger.kernel.org with ESMTP id <S318008AbSGWJus>;
	Tue, 23 Jul 2002 05:50:48 -0400
Date: Tue, 23 Jul 2002 17:53:46 +0800
From: Richard Liu <richliu@ite.techarea.org>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: How to use ioctl write data to ide device?
Message-Id: <20020723174653.4B46.RICHLIU@ite.techarea.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

   I have a ide device which need use special command to configure it.
I want to write a user space program to control it. 

so I try to use ioctl send my command, but after I send IDE command
I must send 512byte to device. 

does anyone know how to write data from user space?

and I have another question, 
    what is "hwif->drives[0].unmask = 1;", how to use it correctly?
--
Richard Liu

