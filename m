Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWF2LEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWF2LEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWF2LEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:04:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26039 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751865AbWF2LEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:04:23 -0400
Subject: Re: [2.6 PATCH] Exporting mmu_cr4_features again for i386 & x86_64
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Milena Milenkovic <mmilenko@us.ibm.com>, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com
In-Reply-To: <200606291255.36206.ak@suse.de>
References: <OF692619AF.8A926C55-ON8725719B.007C1C06-8625719B.007E27C7@us.ibm.com>
	 <200606291255.36206.ak@suse.de>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 13:04:16 +0200
Message-Id: <1151579056.3122.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > However, this variable is needed if a loadable kernel module wants to 
> > enable
> > access to performance counters from user space.
> 
> Ok I guess it's a reasonable request (although we will likely
> eventually add a standard API for this and then it might 
> be removed again) 

I kind of disagree that being a reasonable request; there are several
tools (perfmon/oprofile) that do this already without the export, and if
you want another one, adding a very simple API to do just this to the
kernel should not at all be a big deal, just add that to the patch when
submitting the module for inclusion....


