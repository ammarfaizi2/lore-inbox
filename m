Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264641AbRFZAOp>; Mon, 25 Jun 2001 20:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbRFZAOg>; Mon, 25 Jun 2001 20:14:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9988 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264641AbRFZAO0>; Mon, 25 Jun 2001 20:14:26 -0400
Subject: Re: Linux and system area networks
To: roland@topspincom.com (Roland Dreier)
Date: Tue, 26 Jun 2001 01:14:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com (Pete Zaitcev)
In-Reply-To: <52pubs5fvr.fsf@love-boat.topspincom.com> from "Roland Dreier" at Jun 25, 2001 03:55:20 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EgUb-0002pN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, how about an Infiniband network with a TCP/IP gateway at the edge?
> Have we thought about how Linux servers should use the gateway to talk
> to internet hosts?  Surely there's no point in running TCP/IP inside
> the Infiniband network, so there needs to be some concept of "socket
> over Infiniband."

So write the library, it shouldnt need the kernel involved, and you can
take over AF_INET socket syscalls with an LD_PRELOAD so it can be transparent
