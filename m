Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264528AbSIQTdD>; Tue, 17 Sep 2002 15:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264546AbSIQTdD>; Tue, 17 Sep 2002 15:33:03 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:6137 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264528AbSIQTdC>; Tue, 17 Sep 2002 15:33:02 -0400
Date: Tue, 17 Sep 2002 15:38:02 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-aio@kvack.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: libaio 0.3.92 test release
Message-ID: <20020917153802.K23555@redhat.com>
References: <794826DE8867D411BAB8009027AE9EB913D03F15@fmsmsx38.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <794826DE8867D411BAB8009027AE9EB913D03F15@fmsmsx38.fm.intel.com>; from kenneth.w.chen@intel.com on Tue, Sep 17, 2002 at 12:31:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 12:31:00PM -0700, Chen, Kenneth W wrote:
> several questions regarding to aio-20020916 release:
> 
> In fs/aio.c, it doesn't appear that the API as well as the implementation
> are sync'ed up with what's in 2.5.x.  And this leads to the following
> discrepancy compare to what's in 2.5:

Yeah, I missed a couple and have to add test cases for them to the 
test suite (those test programs were separate from libaio, and will 
soon no longer be).  That'll be fixed in today's test release.

> Is there another release (hopefully soon) to sync up fs/aio.c with 2.5? or
> is it going to be never?

Of course!  Why wouldn't there be?

		-ben
