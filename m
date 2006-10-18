Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423069AbWJRWLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423069AbWJRWLw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWJRWLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:11:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39583 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423069AbWJRWLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:11:51 -0400
Subject: Re: [PATCHv2] Undeprecate the sysctl system call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Cal Peake <cp@absolutedigital.net>, Andi Kleen <ak@suse.de>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061018123115.662ec5c7.akpm@osdl.org>
References: <453519EE.76E4.0078.0@novell.com>
	 <200610181441.51748.ak@suse.de>
	 <1161176382.9363.35.camel@localhost.localdomain>
	 <200610181508.54237.ak@suse.de>
	 <Pine.LNX.4.64.0610181214060.7303@lancer.cnet.absolutedigital.net>
	 <1161189661.9363.83.camel@localhost.localdomain>
	 <20061018123115.662ec5c7.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 23:13:56 +0100
Message-Id: <1161209637.13350.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 12:31 -0700, ysgrifennodd Andrew Morton:
> I agree that those tables in sysctl.h are a right royal pita to maintain. 
> And there sure is a lot of gunk in there which it would be nice to scrap.

I'm arguing that we don't maintain them, we freeze them


