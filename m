Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWFMRbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWFMRbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFMRbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:31:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59881 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750773AbWFMRbl (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:31:41 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number =?iso-8859-15?q?of=09physical_pages_backing?= it
Date: Tue, 13 Jun 2006 19:31:36 +0200
User-Agent: KMail/1.9.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux-mm@kvack.org, Linux-kernel@vger.kernel.org
References: <1149903235.31417.84.camel@galaxy.corp.google.com> <200606130551.23825.ak@suse.de> <1150217948.9576.67.camel@galaxy.corp.google.com>
In-Reply-To: <1150217948.9576.67.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131931.36165.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This information is for user land applications to have the knowledge of
> which virtual ranges are getting actively used and which are not.

If you think the kernel needs better information on that wouldn't
it be better to use the page accessed bits of the hardware more
aggressively?

Before giving up and adding hacks like you're proposing it would
be better to explore fully automatic mechanisms fully.

-Andi
