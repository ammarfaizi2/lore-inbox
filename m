Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWIMEmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWIMEmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 00:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWIMEmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 00:42:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:36742 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751558AbWIMEmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 00:42:08 -0400
Date: Wed, 13 Sep 2006 10:11:24 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Rohit Seth <rohitseth@google.com>
Cc: sekharan@us.ibm.com, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters	(v4)	(added	user	memory)
Message-ID: <20060913044124.GA6640@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1157743424.19884.65.camel@linuxchandra> <1157751834.1214.112.camel@galaxy.corp.google.com> <1157999107.6029.7.camel@linuxchandra> <1158001831.12947.16.camel@galaxy.corp.google.com> <1158003725.6029.60.camel@linuxchandra> <1158019099.12947.102.camel@galaxy.corp.google.com> <1158105253.4800.20.camel@linuxchandra> <1158107948.20211.47.camel@galaxy.corp.google.com> <1158109818.4800.39.camel@linuxchandra> <1158110751.20211.61.camel@galaxy.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158110751.20211.61.camel@galaxy.corp.google.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 06:25:51PM -0700, Rohit Seth wrote:
> And how will the kernel reclaimer know which RGs are don't care?

The UBC code can provide this information certainly. For ex: in my CPU
controller patch, I do keep track of such don't care groups in the
controller itself:

	http://lkml.org/lkml/2006/8/20/120


-- 
Regards,
vatsa
