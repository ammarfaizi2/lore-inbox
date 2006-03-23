Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWCWRyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWCWRyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWCWRyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:54:51 -0500
Received: from mga03.intel.com ([143.182.124.21]:49749 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751441AbWCWRyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:54:49 -0500
X-IronPort-AV: i="4.03,123,1141632000"; 
   d="scan'208"; a="14633212:sNHT158064060"
Subject: Re: [patch] add private data to notifier_block
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Jes Sorensen <jes@sgi.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <yq0u09ptqzq.fsf@jaguar.mkp.net>
References: <Pine.LNX.4.44L0.0603221402070.7453-100000@iolanthe.rowland.org>
	 <1143061212.8924.10.camel@whizzy>  <yq0u09ptqzq.fsf@jaguar.mkp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Mar 2006 10:01:29 -0800
Message-Id: <1143136889.16072.1.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 23 Mar 2006 17:54:17.0777 (UTC) FILETIME=[CE333A10:01C64EA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 05:06 -0500, Jes Sorensen wrote:
> >>>>> "Kristen" == Kristen Accardi <kristen.c.accardi@intel.com> writes:
> 
> Kristen> On Wed, 2006-03-22 at 14:04 -0500, Alan Stern wrote:
> >> I still think this isn't really needed.  The same effect can be
> >> accomplished by embedding a notifier_block struct within a larger
> >> structure that also contains the data pointer.
> 
> Kristen> I thought of this, but felt it would make for less easy to
> Kristen> read code.  But, that's just my personal style.
> 
> I'd have to vote for Alan's side here. Thats why we have the
> containerof() stuff. It also means you can embed more than just a
> pointer with the notifier block and it will generate more efficient
> code when doing so.
> 
> Cheers,
> Jes

Ok, I bow to peer pressure and will do this your way.  :) You can ignore
this patch.

Thanks,
Kristen
