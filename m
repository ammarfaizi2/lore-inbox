Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264532AbUEDRej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbUEDRej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 13:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUEDRej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 13:34:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20699 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264532AbUEDRei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 13:34:38 -0400
Date: Tue, 4 May 2004 14:35:29 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [RFC] Revised CKRM release
Message-ID: <20040504173529.GE11346@logos.cnet>
References: <4090BBF1.6080801@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4090BBF1.6080801@watson.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Apr 29, 2004 at 04:25:21AM -0400, Shailabh Nagar wrote:
> The Class-based Resource Management project is happy to release the
> first bits of a working prototype following a major revision of its
> interface and internal organization.
>
> The basic concepts and motivation of CKRM remain the same as described
> in the overview at http://ckrm.sf.net. Privileged users can define
> classes consisting of groups of kernel objects (currently tasks and
> sockets) and specify shares for these classes. Resource controllers,
> which are independent of each other, can regulate and monitor the
> resources consumed by classes e.g the CPU controller will control the
> CPU time received by a class etc. Optional classification engines,
> implemented as kernel modules, can assist in the automatic
> classification of the kernel objects (tasks/sockets currently) into
> classes.

Cool!

> New in this release are the following:
> 
> rbce.ckrm-E12:
> 
> Two classification engines (CE) to assist in automatic classification
> of tasks and sockets. The first one, rbce, implements a rule-based
> classification engine which is generic enough for most users. The
> second, called crbce, is a variant of rbce which additionally provides
> information on significant kernel events (where a task/socket could
> get reclassified) to userspace as well as reports per-process wait
> times for cpu, memory, io etc. Such information can be used by user
> level tools to reclassify tasks to new classes, change class shares
> etc.

It sounds to me the classification engine can be moved to userspace? 

Such "classification" sounds a better suited to be done there.

Note: I haven't read the code yet.
