Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317832AbSFSJjb>; Wed, 19 Jun 2002 05:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSFSJja>; Wed, 19 Jun 2002 05:39:30 -0400
Received: from web21205.mail.yahoo.com ([216.136.131.248]:39350 "HELO
	web21205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317832AbSFSJj3>; Wed, 19 Jun 2002 05:39:29 -0400
Message-ID: <20020619093930.69906.qmail@web21205.mail.yahoo.com>
Date: Wed, 19 Jun 2002 02:39:30 -0700 (PDT)
From: aryan aru <aryan222is@yahoo.com>
Subject: PCI DMA : pci_map_single usage
To: aryan222is@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C8464AB.3020404@bryanr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am new to this device driver area. I have a question
on PCI DMA usage. Could you plz correct me.

I have two processors, processor(pci device) pA,
processor(pci device) pB. I want to use DMA pull
mechanism for transfering the messages between them. I
need to follow the mechanism for this.

When pA wants to send a pkt to pB:

pA places the address of the src_buff in one of the
common registers. pB, by accessing that register, will
come to know the location of the src_buffer. Now pB,
using its DMA controller has to pull the message to
its local buffer, say dest_loc_buff. For setting up
the dma controller on pB, I need  the pci_addr of
src_buuf and dest_loc_buff( DMA controller of
MPC82xx). 

How can I get pci_addr of src_buff?
Can I get this by using pci_map_single?

>From my understating pci_map_single takes local buffer
as the argument. 

In this transfer, do both the DMA controllers (pA and
pB) involve in message transfer or only pB pulls the
pkt.


Any driver example available in that net for this
"pull" mechanism.

Any help is highly appreciated.

thans and regards
Aryan




__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
