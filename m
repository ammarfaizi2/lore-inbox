Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135269AbRDLT2w>; Thu, 12 Apr 2001 15:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135270AbRDLT2m>; Thu, 12 Apr 2001 15:28:42 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:52948 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S135269AbRDLT23>;
	Thu, 12 Apr 2001 15:28:29 -0400
Message-Id: <m14neyS-000Od1C@amadeus.home.nl>
Date: Thu, 12 Apr 2001 12:09:16 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: alessandro.suardi@oracle.com (Alessandro Suardi)
Subject: Re: 2.4.3-ac3 XIRCOM_CB only working as module
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <3ACC6425.CBF6BCC4@oracle.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3ACC6425.CBF6BCC4@oracle.com> you wrote:
> It looks like the new xircom_cb driver only works as module - if built
>  in kernel there is no sign of eth0 setup.

I haven't tried this; I'll look into this once I get back to work (eg where
my cardbus machine is). I would not be surprised if it
turns out to be of the "yenta_socket is not initialized yet, so the card is
invisible at pci scan time" type....

Greetings,
   Arjan van de Ven

