Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUJGVLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUJGVLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267993AbUJGVIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:08:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42657 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267958AbUJGUld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:41:33 -0400
Message-Id: <200410071918.i97JGlLC014534@owlet.beaverton.ibm.com>
To: Paul Jackson <pj@sgi.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       colpatch@us.ibm.com, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement 
In-reply-to: Your message of "Thu, 07 Oct 2004 10:54:25 PDT."
             <20041007105425.02e26dd8.pj@sgi.com> 
Date: Thu, 07 Oct 2004 12:16:47 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    The users of cpusets need to have system wide names for them, with
    permissions for viewing, modifying and attaching to them, and with the
    ability to list both what hardware (CPUs and Memory) in a cpuset, and
    what tasks are attached to a cpuset.  As is usual in such operating
    systems, the kernel manages such system wide synchronized controlled
    access views.

Well, you are *asserting* the kernel will manage this.  But doesn't
CKRM offer this capability?  The only thing it *can't* do is assure
exclusivity, today .. correct?

Rick
