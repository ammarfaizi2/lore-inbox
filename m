Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVKXSDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVKXSDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbVKXSDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:03:09 -0500
Received: from fsmlabs.com ([168.103.115.128]:16097 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932194AbVKXSDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:03:07 -0500
X-ASG-Debug-ID: 1132855385-21710-6-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 24 Nov 2005 10:08:42 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: Dave Jones <davej@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: Kernel BUG at mm/rmap.c:491
Subject: Re: Kernel BUG at mm/rmap.c:491
In-Reply-To: <1132810499.1921.93.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0511241005180.16752@montezuma.fsmlabs.com>
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com> 
 <cone.1132788250.534735.25446.501@kolivas.org>  <200511232335.15050.s0348365@sms.ed.ac.uk>
  <20051124044009.GE30849@redhat.com> <1132810499.1921.93.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5549
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005, Lee Revell wrote:

> On Wed, 2005-11-23 at 23:40 -0500, Dave Jones wrote:
> > The 'G' seems to confuse a hell of a lot of people.
> > (I've been asked about it when people got machine checks a lot over
> >  the last few months).
> > 
> > Would anyone object to changing it to conform to the style of
> > the other taint flags ? Ie, change it to ' ' ? 
> 
> While you're at it why not print a big loud warning that says not to
> post the Oops to LKML, and instructing the user to reproduce with a

I don't think wasting precious screen real estate on warnings is a good 
idea. The oops may also be of use, there have been occassions where the 
only oops output had a proprietary bit set. The person handling the bug 
report should be the one making the decision as to whether to repost a new 
oops.
