Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSLFRtO>; Fri, 6 Dec 2002 12:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSLFRtO>; Fri, 6 Dec 2002 12:49:14 -0500
Received: from holomorphy.com ([66.224.33.161]:64655 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264943AbSLFRso>;
	Fri, 6 Dec 2002 12:48:44 -0500
Date: Fri, 6 Dec 2002 09:55:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: Erich Focht <efocht@ess.nec.de>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: per cpu time statistics
Message-ID: <20021206175557.GF11023@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	Erich Focht <efocht@ess.nec.de>, Andrew Morton <akpm@zip.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>
References: <200212041343.39734.efocht@ess.nec.de> <1039195903.16948.85.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039195903.16948.85.camel@dyn9-47-17-164.beaverton.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 04:43, Erich Focht wrote:
>> I had to learn from Michael Hohnbaum that you've eliminated the per
>> CPU time statistics in 2.5.50 (akpm changeset from Nov. 26).
> ...
>> For those who miss this feature I'm attaching a patch doing what wli
>> suggested. The config option is CONFIG_CPUS_STAT and can be found in
>> the "Kernel Hacking" menu, as wli suggested. Just didn't like
>> DEBUG_SCHED, we want to monitor the statistics and this is not
>> necessarily related to bugs in the scheduler. Also added as last line
>> in /proc/pid/cpu the current CPU of the task. It's often needed and
>> /proc/pid/stat is much too cryptic.

On Fri, Dec 06, 2002 at 09:31:43AM -0800, Michael Hohnbaum wrote:
> I use a set of tests provided by Erich that use the cpu information from
> the task.  This information is crucial for understanding how processes
> are dispatched across CPUs (and nodes on NUMA boxes).  I've applied
> Erich's patch and it restores this data, making his tests useful.  Could
> this patch be considered for inclusion?  Please.

We've already come to a resolution on this one (going with Erich's patch),
or at least I got that impression.

Bill
