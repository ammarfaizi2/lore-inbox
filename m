Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270273AbRHWUuX>; Thu, 23 Aug 2001 16:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270264AbRHWUuN>; Thu, 23 Aug 2001 16:50:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41922 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270293AbRHWUuF>;
	Thu, 23 Aug 2001 16:50:05 -0400
Date: Thu, 23 Aug 2001 16:50:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard J Moore <richardj_moore@uk.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there any interest in Dynamic API
In-Reply-To: <OF5C54F2B3.04BACD3A-ON80256AB1.004CA1FB@portsmouth.uk.ibm.com>
Message-ID: <Pine.GSO.4.21.0108231646420.15558-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Aug 2001, Richard J Moore wrote:

> 
> 
> On Thu, 23 Aug 2001, Alexander Viro <viro@math.psu.edu>:
> 
> > s/ioctl/read() and write()/, please.
> 
> Why not ioctl?

Because use of read() and write() forces at least some thinking about
making the API you add reasonably clean - ioctl() is "anything goes"
junkpile by design.

