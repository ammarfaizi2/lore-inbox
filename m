Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWHGOzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWHGOzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWHGOzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:55:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35554 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750844AbWHGOzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:55:41 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: notify_page_fault_chain
Date: Mon, 7 Aug 2006 16:55:36 +0200
User-Agent: KMail/1.9.3
Cc: anil.s.keshavamurthy@intel.com, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <44D75ACE.76E4.0078.0@novell.com> <200608071536.40303.ak@suse.de> <44D76F60.76E4.0078.0@novell.com>
In-Reply-To: <44D76F60.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071655.36216.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 16:50, Jan Beulich wrote:
> >> I consider it already questionable to split out a specific  
> >> fault from the general die notification (previous users of the functionality all of the sudden won't get
> notifications
> >> for one of the most crucial faults anymore), but entirely hiding the functionality (unavailable without
> CONFIG_KPROBES,
> >> and even with it not getting exported) is really odd.
> >
> >You want to use it for your debugger? 
> 
> Yes, in its "light" form (i.e. without exception handling framework changes) it has to rely on this infrastructure.

Ok. I can make it unconditional and export it.

-Andi
