Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422987AbWJSFNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422987AbWJSFNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 01:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423251AbWJSFNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 01:13:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16808 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422987AbWJSFNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 01:13:07 -0400
Date: Wed, 18 Oct 2006 22:12:52 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cpuset: remove useless sched domain line
Message-Id: <20061018221252.47861641.pj@sgi.com>
In-Reply-To: <20061018172422.GA7885@in.ibm.com>
References: <20061014045517.22007.863.sendpatchset@v0>
	<20061018172422.GA7885@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> I dont think this is a valid optimization.

I probably don't agree, but I think there might be a better way to deal
with this line of code - remove the entire routine ;).

I have a patch set I am about to send in to lkml for comment, that
removes the entire mechanism connecting cpusets to sched domains,
replacing it with a much simpler (even I can understand) mechanism to
update the isolated_cpu_map on the fly.

If that flies, then this present patch becomes obsolete and irrelevant.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
