Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751935AbWFLMzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbWFLMzB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWFLMzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:55:01 -0400
Received: from ns1.suse.de ([195.135.220.2]:21448 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751935AbWFLMzA (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:55:00 -0400
From: Andi Kleen <ak@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of physical pages backing it
Date: Mon, 12 Jun 2006 14:54:34 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, rohitseth@google.com,
       Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
References: <1149903235.31417.84.camel@galaxy.corp.google.com> <200606121317.44139.ak@suse.de> <Pine.LNX.4.61.0606121449140.1125@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606121449140.1125@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121454.34072.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 14:49, Jan Engelhardt wrote:
> >
> >I agree it's a bad idea. smaps is only a debugging kludge anyways
> >and it's not a good idea to we bloat core data structures for it.
> >
> Is there a way to disable it (smaps), then?

Just don't use it?  

Not set CONFIG_NUMA?  

-Andi
