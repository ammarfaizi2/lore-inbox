Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132126AbRCVSS5>; Thu, 22 Mar 2001 13:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132128AbRCVSSr>; Thu, 22 Mar 2001 13:18:47 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:21010 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S132126AbRCVSSd>;
	Thu, 22 Mar 2001 13:18:33 -0500
Date: Thu, 22 Mar 2001 11:18:42 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: nbecker@fred.net, linux-kernel@vger.kernel.org
Subject: Re: regression testing
Message-ID: <20010322111842.C17926@hq.fsmlabs.com>
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com> <Pine.LNX.3.95.1010322083448.20107C-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.95.1010322083448.20107C-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Mar 22, 2001 at 08:39:06AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} On 22 Mar 2001 nbecker@fred.net wrote:
} 
} > Hi.  I was wondering if there has been any discussion of kernel
} > regression testing.  Wouldn't it be great if we didn't have to depend
} > on human testers to verify every change didn't break something?
} > 
} > OK, I'll admit I haven't given this a lot of thought.  What I'm
} > wondering is whether the user-mode linux could help here (allow a way
} > to simulate controlled activity).
} > -
} 
} Regression testing __is__ what happens when 10,000 testers independently
} try to break the software!

No, in fact that is not a regression test.

} Canned so-called "regression-test" schemes will fail to test at least
} 90 percent of the code paths, while attempting to "test" 100 percent
} of the code!

A canned set of regression tests would actually do what they're supposed to
- prevent the kernel from regressing.  If you fix a bug - write a test for
that bug and keep running it.  Something we follow for RTLinux that has
helped us immensely.
