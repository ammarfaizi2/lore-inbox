Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSHSBNK>; Sun, 18 Aug 2002 21:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSHSBNK>; Sun, 18 Aug 2002 21:13:10 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:58378 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S316586AbSHSBNK>; Sun, 18 Aug 2002 21:13:10 -0400
Date: Mon, 19 Aug 2002 11:16:32 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Alan Cox <alan@redhat.com>
cc: Jeff Dike <jdike@karaya.com>, "David S. Miller" <davem@redhat.com>,
       <kuznet@ms2.inr.ac.ru>, Andi Kleen <ak@muc.de>,
       <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
In-Reply-To: <Mutt.LNX.4.44.0208181055390.6481-100000@blackbird.intercode.com.au>
Message-ID: <Mutt.LNX.4.44.0208191114410.9295-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2002, James Morris wrote:

> On Sat, 17 Aug 2002, Alan Cox wrote:
> 
> > Looks like the lock is needed - oh well
> > 
> 
> It's still lockless in the sigio delivery path, which is where it 
> matters.
> 

Ahh, you're right, of course.  Please disregard the last version of the 
patch.


- James
-- 
James Morris
<jmorris@intercode.com.au>


