Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966049AbWKIRoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966049AbWKIRoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966050AbWKIRoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:44:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966049AbWKIRoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:44:23 -0500
Message-ID: <455368F4.8080203@sandeen.net>
Date: Thu, 09 Nov 2006 11:44:20 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Igor A. Valcov" <viaprog@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
In-Reply-To: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor A. Valcov wrote:
> Hello,
> 
> For one of our projects we have a test program that measures file
> system performance by writing up to 1000 files simultaneously. After
> installing kernel v2.6.16 we noticed that XFS performance dropped by a
> factor of 5 (tests that took around 4 minutes on kernel 2.6.15 now
> take around 20 minutes to complete). 

Ouch.

> We then checked all kernels
> starting from 2.6.16 up to 2.6.19-rc5 with the same unpleasant result.
> The funny thing about all this is that we chose XFS for that
> particular project specifically because it was about 5 times faster
> with the tests than the other file systems. Now they all take about
> the same time.
> 
> I also noticed that I/O barriers were introduced in v2.6.16 and
> thought they may be the cause, but mounting the file system with
> 'nobarrier' doesn't seem to affect the performance in any way.
> 
> Any thoughts on the matter are appreciated.

Can you provide the test?

-Eric
