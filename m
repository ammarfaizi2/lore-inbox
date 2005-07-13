Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVGMR2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVGMR2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMRZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:25:51 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:26107 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261693AbVGMRYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:24:41 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org, torvalds@osdl.org,
       christoph@lameter.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Wed, 13 Jul 2005 10:24:10 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <42D540C2.9060201@tmr.com>
Message-ID: <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050712121008.GA7804@ucw.cz>
 <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org>
 <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Bill Davidsen wrote:

> How serious is the 1/HZ = sane problem, and more to the point how many 
> programs get the HZ value with a system call as opposed to including a header 
> or building it in? I know some of my older programs use header files, that 
> was part of the planning for the future even before 2.5 started. At the time 
> I didn't expect to have to use the system call.

in binary 1/100 or 1/1000 are not sane values to start with so I don't 
think that that this is likly to be that critical (remembering that the 
kernel doesn't do floating point math)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
