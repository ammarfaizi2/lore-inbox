Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137047AbREKFaL>; Fri, 11 May 2001 01:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137048AbREKFaB>; Fri, 11 May 2001 01:30:01 -0400
Received: from mail.zabbadoz.net ([195.2.176.194]:46606 "EHLO
	mail.zabbadoz.net") by vger.kernel.org with ESMTP
	id <S137047AbREKF3t>; Fri, 11 May 2001 01:29:49 -0400
Date: Fri, 11 May 2001 07:29:38 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb+linuxkernel@zabbadoz.net>
To: SodaPop <soda@xirr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: null pointer dereference in ibmtr
In-Reply-To: <200105102013.PAA22503@xirr.com>
Message-ID: <Pine.BSF.4.30.0105110715170.47563-100000@noc.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2001, SodaPop wrote:

> When inserting the ibmtr.o module in any of the 2.4 series kernels, I get a
> null pointer crash.  Latest try was 2.4.4.  Ksymoops:

Hi,

there is a known issue at least I know for the imbtr_cs after a debugging
session with a friend last weekend.

You might want to try
http://www.linuxtr.net/download/ibmtr-all.2.4.2-ac28.patch.gz
till there is an official patch for 2.4.4.

Due to some changes from 2.4.2 to 2.4.4 patch doesn't apply clean but
it's only few lines in rej-file you will have to fix manually.

Redhat unfortunately included this patch in their 2.4.2 rh7.1 kernel
though it is not in the official kernel confusing people even more.

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/


