Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288584AbSAHXnT>; Tue, 8 Jan 2002 18:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288585AbSAHXnJ>; Tue, 8 Jan 2002 18:43:09 -0500
Received: from mxzilla3.xs4all.nl ([194.109.6.49]:26642 "EHLO
	mxzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288584AbSAHXmx>; Tue, 8 Jan 2002 18:42:53 -0500
Date: Wed, 9 Jan 2002 00:42:48 +0100
From: jtv <jtv@xs4all.nl>
To: Greg KH <greg@kroah.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020109004248.C26154@xs4all.nl>
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020108231147.GA16313@kroah.com>; from greg@kroah.com on Tue, Jan 08, 2002 at 03:11:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 03:11:47PM -0800, Greg KH wrote:
> 
> Any reason _why_ they would want to break tons of existing code in this
> manner?  Just the fact that the __func__ symbol is there to use?
 
At a guess, it probably gives the gcc folks some more leeway as to where 
they implement the feature relative to string constant concatenation and 
such.  If that is indeed the case, it could lead to cleaner code.


> Since the C99 spec does not state anything about __FUNCTION__, changing
> it from the current behavior does not seem like a wise thing to do.

I'm pretty sure it's got to be in there somewhere--it was in the summary I 
read at the time.  :)


Jeroen

