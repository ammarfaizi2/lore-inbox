Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRDEFtY>; Thu, 5 Apr 2001 01:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbRDEFtP>; Thu, 5 Apr 2001 01:49:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50564 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132558AbRDEFtL>;
	Thu, 5 Apr 2001 01:49:11 -0400
Date: Thu, 5 Apr 2001 01:48:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Manoj Sontakke <manojs@sasken.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version?
In-Reply-To: <3ACC4F5B.5A1D2923@sasken.com>
Message-ID: <Pine.GSO.4.21.0104050147290.23164-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Apr 2001, Manoj Sontakke wrote:

> Hi
> 	I am getting linker error "undefined reference to __divdi3".
> This is because c = a/b; where a,b,c are of type "long long"
> I understand this is gcc problem.
> 	I am doing this on a pentium with gcc -v = egcs-2.91.66

Don't do it in the kernel. It has nothing to gcc version.

