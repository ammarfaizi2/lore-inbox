Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317717AbSFLPH5>; Wed, 12 Jun 2002 11:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317718AbSFLPH4>; Wed, 12 Jun 2002 11:07:56 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:44721 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317717AbSFLPHy>; Wed, 12 Jun 2002 11:07:54 -0400
Date: Wed, 12 Jun 2002 08:06:58 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Robert Love <rml@tech9.net>,
        Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
Message-ID: <3215445436.1023869217@[10.10.2.3]>
In-Reply-To: <1023820116.22156.271.camel@sinai>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ugh let's stop this thread now.  Two points:
> 
> 	(a) imo, the kernel should support out-of-the-box the maximum
> 	    number of CPUs it can handle.  Be lucky we now have a
> 	    configure option to change that.  But that does not matter..
> 
> 	(b) Right now it is 32.  Now you can change it... if you want
> 	    to change the current behavior by _default_ why don't we
> 	    suggest that _after_ this is accepted into 2.5?  I.e., one
> 	    battle at a time.

Indeed. And before that gets changed, it would be necessary
to change the bootstrap procedure not to crash if you have
more than NR_CPUS cpus (as Andrew reported it did), but instead 
to just not configure them ... much less troublesome.

M.

