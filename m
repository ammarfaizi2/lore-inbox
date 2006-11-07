Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWKGOHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWKGOHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWKGOHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:07:20 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:33442 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S932607AbWKGOHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:07:19 -0500
Message-ID: <455092F5.3090402@in.ibm.com>
Date: Tue, 07 Nov 2006 19:36:45 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, jlan@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, pj@sgi.com,
       mbligh@google.com, winget@google.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [PATCH 2/6] Cpusets hooked into containers
References: <20061020183819.656586000@menage.corp.google.com>	 <20061020190626.810567000@menage.corp.google.com>	 <454ED769.8040302@in.ibm.com> <6599ad830611061255u458a795bpca1c360cb93f253@mail.gmail.com>
In-Reply-To: <6599ad830611061255u458a795bpca1c360cb93f253@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
[snip]

> For the second, the following change to fs/proc/base.c should have
> appeared in cpusets_using_containers.patch, but got left out due to
> quilt misusage. It basically makes "cpuset" an alias for "container"
> in the relevant /proc directories if CONFIG_CPUSETS_LEGACY_API is
> defined.
> 

[snip]

Yeah, this looks much better and more like the fix

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
