Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWFBBdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWFBBdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWFBBdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:33:35 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:3256 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750890AbWFBBdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:33:33 -0400
Message-ID: <447F956B.3090402@bigpond.net.au>
Date: Fri, 02 Jun 2006 11:33:31 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <200606020003.51504.a1426z@gawab.com>
In-Reply-To: <200606020003.51504.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 2 Jun 2006 01:33:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Chandra Seetharaman wrote:
>> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
>>> Kirill Korotaev wrote:
>>>>> Do you have any documented requirements for container resource
>>>>> management?
>>>>> Is there a minimum list of features and nice to have features for
>>>>> containers
>>>>> as far as resource management is concerned?
>>>> Sure! You can check OpenVZ project (http://openvz.org) for example of
>>>> required resource management. BTW, I must agree with other people here
>>>> who noticed that per-process resource management is really useless and
>>>> hard to use :(
>> I totally agree.
>>
>>> I'll take a look at the references. I agree with you that it will be
>>> useful to have resource management for a group of tasks.
> 
> For Resource Management to be useful it must depend on Resource Control.  
> Resource Control depends on per-process accounting.  Per-process accounting, 
> when abstracted sufficiently, may enable higher level routines, preferrably 
> in userland, to extend functionality at will.  All efforts should really go 
> into the successful abstraction of per-process accounting.

I couldn't agree more.  All that's needed in the kernel is low level per 
task control and statistics gathering.  The rest can be done in user space.

Peter
PS I'm a big fan of the various efforts to improve the quality of the 
performance statistics that are exported from the kernel and my only 
wish is that they get together to create one comprehensive solution.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
