Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932904AbWFMF5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbWFMF5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWFMF5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:57:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:24220 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932904AbWFMF5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:57:10 -0400
From: Andi Kleen <ak@suse.de>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of physical_pages_backing it
Date: Tue, 13 Jun 2006 07:56:52 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, rohitseth@google.com, akpm@osdl.org,
       Linux-mm@kvack.org, arjan@infradead.org, jengelh@linux01.gwdg.de
References: <787b0d920606122253o4f1a9e18x1ca49c3ce005696f@mail.gmail.com>
In-Reply-To: <787b0d920606122253o4f1a9e18x1ca49c3ce005696f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130756.52669.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 07:53, Albert Cahalan wrote:
> Quoting two different people:
> 
> > BTW, what is smaps used for (who uses it), anyway?
> ...
> > smaps is only a debugging kludge anyways and it's
> > not a good idea to we bloat core data structures for it.
> 
> I'd be using it in procps for the pmap command if it
> were not so horribly nasty. I may eventually get around
> to using it, but maybe it's just too gross to tolerate.

I agree it's pretty ugly.

But pmap I would consider a debugging kludge too - it should
work when someone needs it, but it doesn't need to be particularly
fast.

-Andi
