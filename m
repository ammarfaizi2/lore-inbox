Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281490AbRK0QWJ>; Tue, 27 Nov 2001 11:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRK0QWA>; Tue, 27 Nov 2001 11:22:00 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42182 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S281504AbRK0QVr>;
	Tue, 27 Nov 2001 11:21:47 -0500
Date: Tue, 27 Nov 2001 21:59:10 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty <rusty@rustcorp.com.au>
Subject: Re: smp_call_function & BH handlers
Message-ID: <20011127215910.I14200@in.ibm.com>
Reply-To: maneesh@in.ibm.com
In-Reply-To: <20011127185739.H14200@in.ibm.com> <Pine.LNX.4.33.0111271626170.17811-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111271626170.17811-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Nov 27, 2001 at 04:28:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 04:28:49PM +0100, Ingo Molnar wrote:
> 
> On Tue, 27 Nov 2001, Maneesh Soni wrote:
> 
> > Why is it ok to call smp_call_function from bottom half handlers? [...]
> 
> which part of the kernel is calling smp_call_function() from bh contexts?
> 
> 	Ingo

I am working with Dipankar on Read-Copy Update, and experimenting with
smp_call_function(). We believed the comments for this routine and faced
this problem. That's why this question came. I have not yet searched 
kernel sources for such places hence not sure whether there are really such
places or not. 

Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html
