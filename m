Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268537AbTANDt2>; Mon, 13 Jan 2003 22:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268556AbTANDt2>; Mon, 13 Jan 2003 22:49:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8387 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268537AbTANDtY>; Mon, 13 Jan 2003 22:49:24 -0500
Date: Mon, 13 Jan 2003 22:58:09 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301140358.h0E3w9X20188@devserv.devel.redhat.com>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: "PCI BIOS passed nonexistant PCI bus 0"
In-Reply-To: <mailman.1042514041.18558.linux-kernel2news@redhat.com>
References: <mailman.1042514041.18558.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   PCI BIOS passed nonexistant PCI bus 1

> How can this be?  I configured the kernel with:
> 
>   # CONFIG_PCI_GOBIOS is not set
>   CONFIG_PCI_GODIRECT=y
> 
> What is this option good for if Linux still listens to what the BIOS says?

How do you think we should go about IRQ routing
without reading BIOS tables? If you have a viable
solution, I'd be happy to listen to it.

Accessing PCI configuration space is trivial. Only two or
three ways actually exist on x86. The IRQ routing is different.
Every little motherboard vendor routes them differently.

-- Pete
