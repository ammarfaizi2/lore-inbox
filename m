Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263829AbTHZMgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTHZMgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:36:20 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:41088 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S263829AbTHZMgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:36:18 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Strange memory usage reporting
References: <yw1xad9w1uj5.fsf@users.sourceforge.net> <20030826122711.GS4306@holomorphy.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 26 Aug 2003 14:36:18 +0200
In-Reply-To: <20030826122711.GS4306@holomorphy.com> (William Lee Irwin,
 III's message of "Tue, 26 Aug 2003 05:27:11 -0700")
Message-ID: <yw1x1xv81tq5.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Tue, Aug 26, 2003 at 02:18:54PM +0200, M?ns Rullg?rd wrote:
>> I was a little surprised to see top tell me this:
>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND           
>> 10642 mru       11   0 23200  81m 2740 S  0.0 37.0   0:00.07 tcvp              
>> It didn't make sense that RES > VIRT, so I check /proc/pid/*.  Their
>> contents are below.  Am I missing something?  Note that they are not
>> consistent with the 'top' line above, since they were copied at a
>> different time.  The effect is easily reproducible.  It happens every
>> time I run my music player with using ALSA.
>> The memory usage summary by top, also doesn't agree:
>
> What kernel version?

Sorry, I forgot that.  It's 2.6.0-test4 with Nick Piggins' v7
scheduler patch.  The machine I'm running on is a Pentium 4 based
laptop.

-- 
Måns Rullgård
mru@users.sf.net
