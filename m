Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751993AbWITRMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWITRMu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWITRMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:12:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55781 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751993AbWITRMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:12:49 -0400
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, rohitseth@google.com,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <451173B5.1000805@yahoo.com.au>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>
	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>
	 <451173B5.1000805@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 18:36:40 +0100
Message-Id: <1158773800.7705.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-21 am 03:00 +1000, ysgrifennodd Nick Piggin:
>  > I've been thinking a bit on that problem, and it would be possible to
>  > share all address_space pages equally between attached containers, this
>  > would lose some accuracy, since one container could read 10% of the file
>  > and another 90%, but I don't think that is a common scenario.
> 
> 
> Yeah, I'm not sure about that. I don't think really complex schemes
> are needed... but again I might need more knowledge of their workloads
> and problems.

Any scenario which permits "cheating" will be a scenario that happens
because people will try and cheat.

Alan

