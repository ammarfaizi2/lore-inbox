Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWJSIq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWJSIq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWJSIq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:46:58 -0400
Received: from gw.goop.org ([64.81.55.164]:50368 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030315AbWJSIq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:46:57 -0400
Message-ID: <45373C1D.9080808@goop.org>
Date: Thu, 19 Oct 2006 01:49:33 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: caglar@pardus.org.tr, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix potential interrupts during alternative patching
 [was	Re: [RFC] Avoid PIT SMP lockups]
References: <1160170736.6140.31.camel@localhost.localdomain>	<453404F6.5040202@vmware.com>	<200610170121.51492.caglar@pardus.org.tr>	<200610171505.53576.caglar@pardus.org.tr> <453730B7.3040906@vmware.com>
In-Reply-To: <453730B7.3040906@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> So this patch is an obvious bugfix - please apply, and to stable as 
> well. I'm not sure when this broke, but taking interrupts in the 
> middle of self modifying code is not a pretty sight.

I had actually seen this when I built the Xen paravirt kernel with SMP 
on, but I assumed it was something in the pv_ops tree rather than 
mainline...

    J
