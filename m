Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264365AbUEYAaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUEYAaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 20:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUEYAaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 20:30:25 -0400
Received: from lvs00-fl-n13.valueweb.net ([216.219.253.195]:59332 "EHLO
	ams013.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S264365AbUEYAaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 20:30:24 -0400
Message-ID: <40B292DD.5060500@coyotegulch.com>
Date: Mon, 24 May 2004 20:27:09 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040522)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: Andi Kleen <ak@muc.de>, "Bryan O'Sullivan" <bos@serpentine.com>,
       brettspamacct@fastclick.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
References: <1Y6yr-eM-11@gated-at.bofh.it> <1085272089.25212.6.camel@obsidian.pathscale.com> <20040523142806.GA33866@colin2.muc.de> <200405241700.57249.habanero@us.ibm.com>
In-Reply-To: <200405241700.57249.habanero@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer wrote:
> FYI Brett, some Opteron systems have a BIOS option to interleave memory.  If 
> you are going to make use of NUMA, I think you want to not interleave.

I can confirm this. On my Tyan Thunder K8W 2885 (dual Opteron), I had to 
disable interleaving (under the Northbridge setup) before Linux 
recognized it as a NUMA system.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing
