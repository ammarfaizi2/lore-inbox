Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUEQUo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUEQUo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 16:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUEQUo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 16:44:27 -0400
Received: from fmr05.intel.com ([134.134.136.6]:48518 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261712AbUEQUoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 16:44:25 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: Christoph Hellwig <hch@infradead.org>, Tim Bird <tim.bird@am.sony.com>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
Date: Mon, 17 May 2004 13:42:49 -0700
User-Agent: KMail/1.5.4
Cc: linux kernel <linux-kernel@vger.kernel.org>
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org>
In-Reply-To: <20040517201910.A1932@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405171342.49891.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 12:19, Christoph Hellwig wrote:
> On Mon, May 17, 2004 at 12:05:36PM -0700, Tim Bird wrote:
> > I am writing to announce the availability of the first draft of
> > the CE Linux Forum's first specification.  This specification
> > represents the efforts of six different technical working groups
> > over about the last 9 months.
>
> If you want my 2Cent:
>
>  - stop these rather useless specifications and provide patchkits instead
>  - try to actually submit the patches upstream to get a feeling which
>    of your 'features' are compltely hopeless, which are okay and which
>    can better be solved in different ways.

All that these "organizations" are doing is collecting REAL requirements for 
features that REAL application developers need.  As well as putting up 
resources to enable the features.

These features represent input from real application developers and system 
integrators on requirements that would be cool for their applications if 
Linux supported them.  Why not look at them from the "what features are 
missing from Linux today and by whom" point of view?

It is also true that most of the requirements exist only if there is some type 
of implementation available.  As such patches for many of the components of 
such specifications are by definition already available at the time of the 
announcement.  (most may need significant work to bring up to date with the 
current kenrel tree, but they do exist)  

The patches do get submitted on a regular basis to the LKML.  Many seem to get 
ignored.  Some of them should, but it seems to me that if features keep 
coming up as requirements in such "specifications" and resources continue to 
work on the feature, then there must be some real need for it.  

BTW, Has anyone actually looked at the latest high res timer patch for 2.6.5?  
I has a new design for the sub-jiffies timer interrupt source.  

It provides an implementation of a the missing feature of low jitter (< 1ms), 
system wide time base via a standard API. ( POSIX would be nice)  

--mgross
My opinions are my own and not that of my employer, duh.

>
> (same applies to CGL/DCL/$INDUSTRYCONSORTIUM)

