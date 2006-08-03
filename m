Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWHCU3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWHCU3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWHCU3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:29:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1990 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751118AbWHCU3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:29:41 -0400
Subject: Re: frequent slab corruption (since a long time)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       jbaron@redhat.com
In-Reply-To: <20060803175613.GK22448@redhat.com>
References: <20060801.220538.89280517.davem@davemloft.net>
	 <20060801.223110.56811869.davem@davemloft.net>
	 <20060802222321.GH3639@redhat.com>
	 <20060802.154954.112624420.davem@davemloft.net>
	 <1154626843.23655.101.camel@localhost.localdomain>
	 <20060803175613.GK22448@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 21:48:32 +0100
Message-Id: <1154638112.23655.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 13:56 -0400, ysgrifennodd Dave Jones:
> Against my better judgment I was poring over that code until the wee
> hours last night, and one thing crossed my mind re: the assumptions made
> about the BKL in that subsystem.  Now that the BKL is preemtible, do
> any of those assumptions break ?

>From the walking of the code so far I think quite a few of them were
already broken. I'm still annotating and I hope by the end of this
evening I'll have a patch to post that documents the current state of
affairs better, including some gems 8)

