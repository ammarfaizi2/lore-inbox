Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSLUAP6>; Fri, 20 Dec 2002 19:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSLUAP6>; Fri, 20 Dec 2002 19:15:58 -0500
Received: from magic.adaptec.com ([208.236.45.80]:54422 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261495AbSLUAP5>; Fri, 20 Dec 2002 19:15:57 -0500
Date: Fri, 20 Dec 2002 17:23:42 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <176730000.1040430221@aslan.btc.adaptec.com>
In-Reply-To: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an Adaptec AIC-7897 Ultra2 SCSI adapter on a system with 8G
> of physical memory.  The adapter is using bounce buffers when DMA'ing
> to memory >4G because of a bug in the aic7xxx driver. 

This has been fixed in both the aic7xxx and aic79xx drivers for some
time.  The problem is that these later revisions have not been integrated
into the mainline trees.

--
Justin

