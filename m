Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSHRJMW>; Sun, 18 Aug 2002 05:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHRJMW>; Sun, 18 Aug 2002 05:12:22 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:59063 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S312590AbSHRJMV>; Sun, 18 Aug 2002 05:12:21 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 05:16:21 -0400
Message-Id: <1029662182.2970.23.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 05:10, Alexander Viro wrote:
> 
> 
> On 18 Aug 2002, Ed Sweetman wrote:
> 
> > (overview written in hindsight of writing email)  
> > I ran all these tests on ide/host2/bus0/target0/lun0/part1 
> 
> Don't be silly - if you want to test anything, devfs is the last thing
> you want on the system.
> 
> 


OK, i can remove devfs, but I dont really see how that would make dma
transfers (memory) become corrupted and pio mode transfers (memory) to
not.  

I'm going to remove it, but i dont see how it's going to affect what's
going on. 

