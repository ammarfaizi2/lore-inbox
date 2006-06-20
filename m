Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWFTIsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWFTIsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWFTIsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:48:43 -0400
Received: from ns1.suse.de ([195.135.220.2]:20704 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965064AbWFTIsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:48:42 -0400
From: Andi Kleen <ak@suse.de>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: [patch] do_no_pfn
Date: Tue, 20 Jun 2006 10:48:10 +0200
User-Agent: KMail/1.9.3
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Carsten Otte <cotte@de.ibm.com>, bjorn_helgaas@hp.com
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <200606201013.10353.ak@suse.de> <4497B490.90303@sgi.com>
In-Reply-To: <4497B490.90303@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201048.10545.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please go back and read the old threads on this for all the details,
> I would miss half the points if I was to try and restate it all from
> memory.

Shouldn't these points be in the patch submission description? 

> Doing this at mmap time does not work, you want NUMA node locality.
> It has to be done through first touch mappings.

Then create struct page *s.

-Andi
