Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSHSBdn>; Sun, 18 Aug 2002 21:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSHSBdn>; Sun, 18 Aug 2002 21:33:43 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:62730 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S316880AbSHSBdm>; Sun, 18 Aug 2002 21:33:42 -0400
Date: Mon, 19 Aug 2002 11:37:18 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jeff Dike <jdike@karaya.com>
cc: "David S. Miller" <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       Andi Kleen <ak@muc.de>, <viro@math.psu.edu>,
       <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31 [version 2] 
In-Reply-To: <200208190228.VAA04400@ccure.karaya.com>
Message-ID: <Mutt.LNX.4.44.0208191134350.9316-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2002, Jeff Dike wrote:

> This is still wrong.  You need to be checking fown->pid in the loop.
> 
> Same thing in send_sigurg.

It still won't work, it needs a lock.


- James
-- 
James Morris
<jmorris@intercode.com.au>


