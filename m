Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVEKU7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVEKU7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVEKU7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:59:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12756 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261229AbVEKU7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:59:01 -0400
Date: Wed, 11 May 2005 13:58:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: ntl@pobox.com, dino@in.ibm.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050511135850.3df60a9f.pj@sgi.com>
In-Reply-To: <20050511134235.5cecf85c.pj@sgi.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050511134235.5cecf85c.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, that last patch obviously doesn't do all that I said
it did - it doesn't do the final fallback to cpu_online_map,
if no cpu in tsk->cpuset->cpus_allowed is online.

Another variation will be forthcoming soon.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
