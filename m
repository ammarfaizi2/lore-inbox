Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVEKT0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVEKT0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVEKT0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:26:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9385 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262025AbVEKT0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:26:04 -0400
Date: Wed, 11 May 2005 12:25:43 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       nickpiggin@yahoo.com.au, vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050511122543.6e9f6097.pj@sgi.com>
In-Reply-To: <20050511191654.GA3916@in.ibm.com>
References: <20050511191654.GA3916@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> It looks like hotplug operations need to take cpuset_sem as well.

Could you explain why this is -- what is the deadlock?  I don't doubt
you found a deadlock, but since I don't understand it yet, it is
difficult for me to judge whether this is the best fix.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
