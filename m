Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268526AbTCAIQx>; Sat, 1 Mar 2003 03:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268528AbTCAIQx>; Sat, 1 Mar 2003 03:16:53 -0500
Received: from holomorphy.com ([66.224.33.161]:40841 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268526AbTCAIQx>;
	Sat, 1 Mar 2003 03:16:53 -0500
Date: Sat, 1 Mar 2003 00:27:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bkcurr
Message-ID: <20030301082700.GD1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030301055922.GB1399@holomorphy.com> <20030301073655.GA1195@holomorphy.com> <20030301074035.GB1195@holomorphy.com> <20030301074616.GC1195@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301074616.GC1195@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 11:36:55PM -0800, William Lee Irwin III wrote:
>>> Use per-cpu rq's in the sched.c to avoid remote cache misses there.
>>> It actually means something now.

On Fri, Feb 28, 2003 at 11:40:35PM -0800, William Lee Irwin III wrote:
>> Tentative followup #2 -- totally untested, at some point I have to
>> figure out how to avoid breaking the compile for non-NUMA-Q with this.

Tested. it works.


-- wli
