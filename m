Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWGLVrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWGLVrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWGLVrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:47:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29623 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751398AbWGLVrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:47:11 -0400
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andrea@cpushare.com
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060712210545.GB24367@opteron.random>
References: <20060629192121.GC19712@stusta.de>
	 <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	 <20060711041600.GC7192@opteron.random>
	 <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	 <20060712210545.GB24367@opteron.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 23:02:56 +0100
Message-Id: <1152741776.22943.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 23:05 +0200, ysgrifennodd andrea@cpushare.com:
> Measuring time through the network currently is impractical, the rtt is
> too huge for that (though perhaps 10 years from now we'll have to
> rethink about this).

Actually measuring time through the network is extremely doable given
enough samples as is communication through delay perturbation. A good
viterbi encoder/decoder will fish a signal out of very high noise. Yes
you pay a lot in data rate at that point but it works.

Anyway at the point you pass the bytecode through a processing filter
you don't need SECCOMP because your filter can remove any syscall
attempts. 

Alan

