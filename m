Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278648AbRJSUVw>; Fri, 19 Oct 2001 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278649AbRJSUVm>; Fri, 19 Oct 2001 16:21:42 -0400
Received: from [207.8.4.6] ([207.8.4.6]:31714 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S278648AbRJSUVe>;
	Fri, 19 Oct 2001 16:21:34 -0400
Message-ID: <3BD08B57.1070604@interactivesi.com>
Date: Fri, 19 Oct 2001 15:21:43 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Allocating more than 890MB in the kernel?
In-Reply-To: <Pine.LNX.4.30.0110191204210.21846-100000@hill.cs.ucr.edu> <3BD08207.7090807@interactivesi.com> <9qq0mo$eun$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> That's because you're running out of address space, not memory.
> HIGHMEM doesn't do anything for the latter -- it can't.  You start
> running into a lot of fundamental problems when your memory size gets
> in the same (or higher) ballpark than your address space.
> 
> The best solution is go buy a 64-bit CPU.  There isn't much else you
> can do about it.


That's completely missing the point of my request (which, I admit, I didn't 
make clear).  I need to allocate about 3/4 of available memory in the kernel. 
  If I had 2GB of RAM, I'd need to allocate 1.5GB.  If I had 8 GB of RAM, I'd 
need to allocate 6GB.  I just used 3GB/4GB because it's our current test platform.

