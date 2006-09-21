Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWIUAgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWIUAgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWIUAgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:36:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19610 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750773AbWIUAgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:36:46 -0400
Date: Wed, 20 Sep 2006 17:36:38 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: clameter@sgi.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920173638.370e774a.pj@sgi.com>
In-Reply-To: <1158798715.6536.115.camel@linuxchandra>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	<1158798715.6536.115.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra wrote:
> AFAICS, That doesn't help me in over committing resources.

I agree - I don't think cpusets plus fake numa ... handles over commit.
You might could hack up a cheap substitute, but it wouldn't do the job.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
