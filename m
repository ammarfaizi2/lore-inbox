Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUCLQhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbUCLQhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:37:07 -0500
Received: from main.gmane.org ([80.91.224.249]:32926 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262294AbUCLQhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:37:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike Hearn <mh@codeweavers.com>
Subject: Re: [PATCH] binfmt_elf.c allow .bss with no access (p---)
Date: Fri, 12 Mar 2004 16:42:11 +0000
Organization: CodeWeavers, Inc
Message-ID: <pan.2004.03.12.16.42.11.387702@codeweavers.com>
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <m1brn8us96.fsf@ebiederm.dsl.xmission.com> <404C0B57.6030607@BitWagon.com> <20040308080615.GS31589@devserv.devel.redhat.com> <4050047F.5010808@BitWagon.com> <pan.2004.03.11.14.23.07.585954@codeweavers.com> <4050BBA1.2080804@BitWagon.com>
Reply-To: mike@theoretic.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e-ucs036.dur.ac.uk
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004 11:18:57 -0800, John Reiser wrote:
> Yes, because the patch considers each PT_LOAD with p_filesz < p_memsz
> to have a "local" .bss.  This is more general than plain 2.6.3 which
> creates only one "global" BSS after accumulating information from all
> of the PT_LOAD.

Fantastic. I'm afraid I'm unfamiliar with the kernel development process,
how do I track the patch to find out when it's checked in and which
releases it's available in (we'd really like 2.4 as well, though it may be
too late to make it worthwhile for now....)

thanks -mike

