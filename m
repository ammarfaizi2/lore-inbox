Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTFCRLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTFCRLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:11:11 -0400
Received: from holomorphy.com ([66.224.33.161]:17320 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261180AbTFCRLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:11:09 -0400
Date: Tue, 3 Jun 2003 10:24:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [BENCHMARK] 100Hz preempt v nopreempt contest results
Message-ID: <20030603172431.GW8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200306031639.49515.kernel@kolivas.org> <1054659956.633.85.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054659956.633.85.camel@localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 23:39, Con Kolivas wrote:
>> Note this time the ratio is less useful since they are both 100Hz. The 
>> difference this time shows a large preempt improvement in process_load much 
>> like 1000Hz did. Interestingly, even unloaded kernels no_load and cache_load 
>> runs are faster with preempt. Only in xtar_load (repeatedly extracting a tar 
>> with multiple small files) was no preempt faster.

On Tue, Jun 03, 2003 at 10:05:58AM -0700, Robert Love wrote:
> Thanks for running these, Con.
> I think this is an example of kernel preemption doing exactly what we
> want it to (improve interactive performance)... probably primarily
> because of the more accurate timeslice distribution.
> Would be interested to figure out why xtar_load is slower.

It would be helpful to get more accurate time accounting a la Mike
Galbraith's patches.


-- wli
