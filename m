Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030605AbVKXHYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030605AbVKXHYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbVKXHYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:24:21 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27606 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030605AbVKXHYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:24:20 -0500
Subject: Re: Kernel BUG at mm/rmap.c:491
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051124044009.GE30849@redhat.com>
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com>
	 <cone.1132788250.534735.25446.501@kolivas.org>
	 <200511232335.15050.s0348365@sms.ed.ac.uk>
	 <20051124044009.GE30849@redhat.com>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 00:34:58 -0500
Message-Id: <1132810499.1921.93.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 23:40 -0500, Dave Jones wrote:
> The 'G' seems to confuse a hell of a lot of people.
> (I've been asked about it when people got machine checks a lot over
>  the last few months).
> 
> Would anyone object to changing it to conform to the style of
> the other taint flags ? Ie, change it to ' ' ? 

While you're at it why not print a big loud warning that says not to
post the Oops to LKML, and instructing the user to reproduce with a
clean kernel, if the P flag is set?  Presumably the reason for the terse
output is to get the maximum possible debug information on the screen,
but we don't care about stack traces for tainted kernels anyway.  

Something must need fixing, as the volume of tainted Oops reports shows
no sign of diminishing, and the users aren't getting any less pissy when
you tell them to come back with a clean bug report.

Lee 

