Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131720AbRCVNss>; Thu, 22 Mar 2001 08:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbRCVNsi>; Thu, 22 Mar 2001 08:48:38 -0500
Received: from adglinux1.hns.com ([139.85.108.152]:35020 "EHLO
	adglinux1.hns.com") by vger.kernel.org with ESMTP
	id <S131720AbRCVNsa>; Thu, 22 Mar 2001 08:48:30 -0500
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: regression testing
In-Reply-To: <Pine.LNX.3.95.1010322083448.20107C-100000@chaos.analogic.com>
Content-Type: text/plain; charset=US-ASCII
From: nbecker@fred.net
Date: 22 Mar 2001 08:47:27 -0500
In-Reply-To: <Pine.LNX.3.95.1010322083448.20107C-100000@chaos.analogic.com>
Message-ID: <x88vgp1gbkg.fsf@adglinux1.hns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

    Richard> On 22 Mar 2001 nbecker@fred.net wrote:
    >> Hi.  I was wondering if there has been any discussion of kernel
    >> regression testing.  Wouldn't it be great if we didn't have to depend
    >> on human testers to verify every change didn't break something?
    >> 
    >> OK, I'll admit I haven't given this a lot of thought.  What I'm
    >> wondering is whether the user-mode linux could help here (allow a way
    >> to simulate controlled activity).
    >> -

The problem I see, based on reading this list, is that the testing is
not so thorough as you say.  First of all, do we really know how many
people test the pre-relase kernels?  How about which features they
actually test?

In principle, we could find out how much test coverage there is.

The problem with an army of testers, is that after an individual has
gone through the build/install/screw-around-with-it process a few
hundred times, it starts to get a bit repetitive.  They start to get
sloppy and haphazard regarding what they test or whether they even try
out xxx-pre<put_big_number_here> at all.  If we could automate at
least some basic testing that would be a big win.
