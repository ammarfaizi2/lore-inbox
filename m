Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWJRQii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWJRQii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWJRQii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:38:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16859 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161228AbWJRQig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:38:36 -0400
Subject: Re: [PATCHv2] Undeprecate the sysctl system call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cal Peake <cp@absolutedigital.net>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610181214060.7303@lancer.cnet.absolutedigital.net>
References: <453519EE.76E4.0078.0@novell.com>
	 <200610181441.51748.ak@suse.de>
	 <1161176382.9363.35.camel@localhost.localdomain>
	 <200610181508.54237.ak@suse.de>
	 <Pine.LNX.4.64.0610181214060.7303@lancer.cnet.absolutedigital.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 17:41:01 +0100
Message-Id: <1161189661.9363.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 12:20 -0400, ysgrifennodd Cal Peake:
> Until something better comes along this'll get us back to the status quo.
> 
> @Andrew, this patch is a replacement for the one from yesterday.
> 
> From: Cal Peake <cp@absolutedigital.net>
> 
> Undeprecate the sysctl system call and default to always include it with
> the option for embedded folks to exclude it.  Also, remove it's entry from
> the feature removal file and fixup the comment in it's header file.
> 
> Signed-off-by: Cal Peake <cp@absolutedigital.net>

Acked-by: Alan Cox <alan@redhat.com>

Maybe also add "Do not add new entries to these tables" to address
Andi's concern about people updating them.
