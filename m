Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVAMRS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVAMRS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVAMRSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:18:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41700 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261256AbVAMRRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:17:51 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105632757.4624.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 16:12:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 16:38, Linus Torvalds wrote:
> It wouldn't be a global flag. It's a per-process flag. For example, many 
> people _do_ need to execute binaries in their home directory. I do it all 
> the time. I know what a compiler is.

noexec has never been worth anything because of scripts. Kernel won't
load that binary, I can write a script to do it.

