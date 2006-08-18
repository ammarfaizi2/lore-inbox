Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWHRAjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWHRAjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 20:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWHRAjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 20:39:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:54662 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932099AbWHRAjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 20:39:07 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=ttg5je9Cv73arVasWlly+wsS4PI3dSlx/jCPX1ndrcaI/UKNBzB0oHrw/QFUMLCuz
	dSkOX1t4AZzeGnL+W77yg==
Message-ID: <44E50B5D.9060506@google.com>
Date: Thu, 17 Aug 2006 17:35:41 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>
CC: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808211731.GR14627@postel.suug.ch>	<44DBED4C.6040604@redhat.com>	<44DFA225.1020508@google.com>	<20060813.165540.56347790.davem@davemloft.net>	<44DFD262.5060106@google.com>	<20060813185309.928472f9.akpm@osdl.org>	<1155530453.5696.98.camel@twins>	<20060813215853.0ed0e973.akpm@osdl.org>	<44E3E964.8010602@google.com> <20060816225726.3622cab1.akpm@osdl.org> <44E5015D.80606@google.com>
In-Reply-To: <44E5015D.80606@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Andrew Morton wrote:
>> Processes which are dirtying those pages throttle at
>> /proc/sys/vm/dirty_ratio% of memory dirty.  So it is not possible to "fill"
>> memory with dirty pages.  If the amount of physical memory which is dirty
>> exceeds 40%: bug.
> 
> So we make 400 MB of a 1 GB system unavailable for write caching just to
> get around the network receive starvation issue?

Excuse me, 600 MB of a 1 GB system :-/

Regards,

Daniel
