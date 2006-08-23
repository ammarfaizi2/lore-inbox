Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWHWLYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWHWLYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWHWLYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:24:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:55007 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932343AbWHWLYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:24:22 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Date: Wed, 23 Aug 2006 13:22:44 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <p73fyfn7nzz.fsf@verdi.suse.de> <20060823103956.GB697@frankl.hpl.hp.com>
In-Reply-To: <20060823103956.GB697@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231322.44106.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a second thought on this. AMD has architected the performance counters.

Quote:
>>
Implementations are not required to support the performance
c o u n t e rs and the event-select registers, or the time-stamp
counter. The presence of these features can be determined by
<<

Also all code I've seen checked the family at least.


> Their specification is not part of a model specific documentation but
> part of the AMD64 architecure. 

The high level specification is, but not the actual counters for once.

> What I don't not quite understand with the K7, K8 terminology is the
> relation/dependencies with the AMD64 architecture specification.
AMD64 gives a high level register format, K7/K8 is the actual list 
of performance counters.

-Andi

