Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbWFVWqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWFVWqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWFVWqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:46:52 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:43415 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750779AbWFVWqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:46:51 -0400
Message-ID: <449B1DD9.9060903@bigpond.net.au>
Date: Fri, 23 Jun 2006 08:46:49 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Matt Helsley <matthltc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       LSE-Tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [PATCH 00/11] Task watchers:  Introduction
References: <1150242721.21787.138.camel@stark>	 <4498DC23.2010400@bigpond.net.au> <1150876292.21787.911.camel@stark>	 <44992EAA.6060805@bigpond.net.au> <44993079.40300@bigpond.net.au>	 <1150925387.21787.1056.camel@stark> <4499D097.5030604@bigpond.net.au>	 <1150936337.21787.1114.camel@stark> <4499EE29.9020703@bigpond.net.au>	 <1150947965.21787.1228.camel@stark>  <449A1C0D.7030906@bigpond.net.au>	 <1150954621.21787.1272.camel@stark>  <449A38BE.9070606@bigpond.net.au> <1151006016.26136.16.camel@linuxchandra>
In-Reply-To: <1151006016.26136.16.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 22 Jun 2006 22:46:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Thu, 2006-06-22 at 16:29 +1000, Peter Williams wrote:
> 
>> Peter
>> PS A year or so ago the CKRM folks promised to have a look at using PAGG 
>> instead of inventing their own but I doubt that they ever did.
> 
> I think it was about 2 years back. We weren't going to re-invent after
> that point, we had a full implementation at that time.
> 
> If i remember correct, we concluded that some design constraints and
> additional overhead were the reasons for not proceeding in that
> direction.
> 
> BTW, if i remember correct, PAGG folks also promised to look at CKRM to
> see if they could use CKRM instead.

I don't recall them promising that but I (personally) looked at CKRM and 
decided that its equivalent functionality was unsuitable as it only 
allowed one client (unlike PAGG and task watchers).  CKRM at that stage 
was one big amorphous lump and trying to use sub components wasn't easy 
as they had been designed to meet CKRM's needs only rather than 
providing some generally useful functionality.

I'm pleased to say that (unless I'm mistaken) that last bit is no longer 
true and CKRM is moving towards providing low level functionality that 
may be generally useful rather than just meeting CKRM's needs.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
