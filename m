Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132579AbRDEJDZ>; Thu, 5 Apr 2001 05:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbRDEJDG>; Thu, 5 Apr 2001 05:03:06 -0400
Received: from samar.sasken.com ([164.164.56.2]:63140 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S132579AbRDEJDD>;
	Thu, 5 Apr 2001 05:03:03 -0400
Date: Thu, 5 Apr 2001 19:39:14 +0530 (IST)
From: Manoj Sontakke <manojs@sasken.com>
To: Alexander Viro <viro@math.psu.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version?
In-Reply-To: <Pine.GSO.4.21.0104050147290.23164-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On Thu, 5 Apr 2001, Alexander Viro wrote:
> On Thu, 5 Apr 2001, Manoj Sontakke wrote:
> 
> > Hi
> > 	I am getting linker error "undefined reference to __divdi3".
> > This is because c = a/b; where a,b,c are of type "long long"
> > I understand this is gcc problem.
> > 	I am doing this on a pentium with gcc -v = egcs-2.91.66
> 
> Don't do it in the kernel. It has nothing to gcc version.

Addition and subtraction works fine. The problem is with multiplication
and division. I am doing this to avoid floating point calculation and
doing fixed point calculation. The rage is large enough to need "long
long" Any other way to achieve this?

thanks
manoj

