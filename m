Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161354AbWJ3U52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161354AbWJ3U52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWJ3U52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:57:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24720 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161354AbWJ3U51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:57:27 -0500
Date: Mon, 30 Oct 2006 12:56:27 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030125627.3b8d6472.pj@sgi.com>
In-Reply-To: <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	<20061030031531.8c671815.pj@sgi.com>
	<6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
	<20061030042714.fa064218.pj@sgi.com>
	<6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
	<20061030123652.d1574176.pj@sgi.com>
	<6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> More concretely:
> 
> - there is a single hierarchy of process containers
> - each process is a member of exactly one process container
> 
> - for each resource controller, there's a hierarchy of resource "nodes"
> - each process container is associated with exactly one resource node
>   of each type
> 
> - by default, the process container hierarchy and the resource node
>   hierarchies are isomorphic, but that can be controlled by userspace.

nice

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
