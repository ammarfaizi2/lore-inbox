Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUE2DZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUE2DZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 23:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUE2DZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 23:25:51 -0400
Received: from holomorphy.com ([207.189.100.168]:3968 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262906AbUE2DZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 23:25:48 -0400
Date: Fri, 28 May 2004 20:25:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfsd oops 2.6.7-rc1
Message-ID: <20040529032540.GA1310@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <20040529023550.GB2370@holomorphy.com> <16568.621.199870.484447@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16568.621.199870.484447@cse.unsw.edu.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 28, wli@holomorphy.com wrote:
>> While idle, the following oops happened. On virgin 2.6.7-rc1.
>> 

On Sat, May 29, 2004 at 01:24:29PM +1000, Neil Brown wrote:
> Ok, I think I've found it.  There is a missing dget.  See below/.
> NeilBrown

Thanks! Testing ETA 10-15 minutes (time needed for kernel compiles).


-- wli
