Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVAJUfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVAJUfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVAJUc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:32:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17869 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262507AbVAJU2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:28:19 -0500
Subject: Re: Proper procedure for reporting possible security
	vulnerabilities?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steve Bergman <steve@rueb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E2B181.3060009@rueb.com>
References: <41E2B181.3060009@rueb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105383104.12004.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 19:24:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 16:46, Steve Bergman wrote:
> So what is the preferred procedure and is it documented somewhere?  
> Should it be made more prominent?

Good question. The preferred procedure depends on your viewpoint on
disclosure

vendor-sec@lst.de is a cross vendor security list and a good place for
stuff. It will deal with both public and date embargoed security
information. security@[your-vendor] should work for most responsible
vendors and may be more appropriate if it involves a vendor kernel that
may have bugs not in the base tree. 

For stuff in -bk kernel snapshots and the like that isn't in the
production kernels then I'd start by mailing Linus/(Andrew for -mm) or
the list.

Alan

