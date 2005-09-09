Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbVIIIGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVIIIGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVIIIGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:06:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45742 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751442AbVIIIGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:06:37 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2.6.13] x86_64: Make trap_init() happen earlier
Date: Fri, 9 Sep 2005 10:01:20 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bob Picco <bob.picco@hp.com>
References: <20050908163757.GQ3966@smtp.west.cox.net>
In-Reply-To: <20050908163757.GQ3966@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091001.20571.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:37, Tom Rini wrote:
> It can be handy in some situations to have run trap_init() sooner than the
> generic code does.  In order to do this on x86_64 we need to add a custom
> early_setup_per_cpu_areas() call as well.

Queued, thanks.
-Andi

