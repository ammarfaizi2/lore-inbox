Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVCCMJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVCCMJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVCCMFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:05:17 -0500
Received: from [81.2.110.250] ([81.2.110.250]:41683 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261618AbVCCMEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:04:25 -0500
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050302222826.GS1512@redhat.com>
References: <20050228192001.GA14221@apps.cwi.nl>
	 <1109721162.15795.47.camel@localhost.localdomain>
	 <20050302075037.GH20190@apps.cwi.nl> <20050302080255.GA28512@redhat.com>
	 <1109771140.20986.3.camel@localhost.localdomain>
	 <20050302222106.GI20190@apps.cwi.nl>  <20050302222826.GS1512@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109851329.21781.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Mar 2005 12:02:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-02 at 22:28, Dave Jones wrote:
> The winchips had a funky feature where you could mark system ram
> writes as out-of-order. This led to something like a 25% speedup iirc
> on benchmarks that did lots of memory copying. lmbench showed
> significant wins iirc, but any results I had saved are long since
> wiped out in hard disk failures/cruft removal over the years.

Yep - providing your kernel is built for it you get about 20-30% speed
up against a base kernel. It's the one freak case (in 2.4 anyway) where
kernel cpu options matter.

Alan

