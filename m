Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319810AbSIMWJA>; Fri, 13 Sep 2002 18:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319811AbSIMWJA>; Fri, 13 Sep 2002 18:09:00 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:17863 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319810AbSIMWIS>;
	Fri, 13 Sep 2002 18:08:18 -0400
Message-ID: <1031955140.3d8262c4c1de9@imap.linux.ibm.com>
Date: Fri, 13 Sep 2002 15:12:20 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: linux-kernel@vger.kernel.org, todd-lkml@osogrande.com
Cc: tcw@tempest.prismnet.com, pfeather@cs.unm.edu, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <Pine.LNX.4.44.0209131553510.10203-100000@gp>
In-Reply-To: <Pine.LNX.4.44.0209131553510.10203-100000@gp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting todd-lkml@osogrande.com:

> dave, all,
> 
> not sure i understand what you're proposing, but while we're at it,
> why not also make the api for apps to allocate a buffer in userland
> that (for nics that support it) the nic can dma directly into?  it

I believe thats exactly what David was referring to - reverse
direction sendfile() so to speak.. 

> seems likely notification that the buffer was used would have to
> travel through the kernel, but it would be nice to save the
> interrupts altogether. 

However, I dont think what youre saving are interrupts as 
much as the extra copy, but I could be wrong..

thanks,
Nivedita



