Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUHENrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUHENrY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267688AbUHENrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:47:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:46733 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267677AbUHENkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:40:16 -0400
Date: Thu, 5 Aug 2004 15:34:43 +0200
From: Andi Kleen <ak@suse.de>
To: arjanv@redhat.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Automatically enable bigsmp on big HP machines
Message-Id: <20040805153443.106c8915.ak@suse.de>
In-Reply-To: <1091711039.2790.1.camel@laptop.fenrus.com>
References: <20040805143837.4a6dce7e.ak@suse.de>
	<1091711039.2790.1.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2004 15:03:59 +0200
Arjan van de Ven <arjanv@redhat.com> wrote:

> On Thu, 2004-08-05 at 14:38, Andi Kleen wrote:
> > This enables apic=bigsmp automatically on some big HP machines that need it. 
> > This makes them boot without kernel parameters on a generic arch kernel.
> 
> is it possible for this to use the new dmi infrastructure, eg not add it
> to dmi_scan.c but to the place where it's used ?

Certainly. Feel free to post a patch for that.

-Andi

> 
