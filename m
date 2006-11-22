Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162027AbWKVKmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162027AbWKVKmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162031AbWKVKmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:42:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:36031 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162027AbWKVKmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:42:43 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Date: Wed, 22 Nov 2006 11:42:21 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Noll <maan@systemlinux.org>,
       David Rientjes <rientjes@cs.washington.edu>, Mel Gorman <mel@skynet.ie>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de>
In-Reply-To: <20061121212424.GQ5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221142.21212.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ject    : x86_64: Bad page state in process 'swapper'
> References : http://lkml.org/lkml/2006/11/10/135
>              http://lkml.org/lkml/2006/11/10/208
> Submitter  : Andre Noll <maan@systemlinux.org>
> Handled-By : David Rientjes <rientjes@cs.washington.edu>
> Status     : problem is being debugged

Does this still happen with -rc6? 

It's probably another bug in the memmap parsing rewrite (Mel cc'ed) 
but the debugging information in the standard kernel unfortunately
doesn't give enough output to find out where it happens.

-Andi
