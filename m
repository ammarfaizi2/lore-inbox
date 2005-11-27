Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVK0Nrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVK0Nrj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 08:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVK0Nrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 08:47:39 -0500
Received: from ns2.suse.de ([195.135.220.15]:56288 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751050AbVK0Nri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 08:47:38 -0500
Date: Sun, 27 Nov 2005 14:47:36 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, paulmck@us.ibm.com, kaos@sgi.com,
       greg@kroah.com, Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-ID: <20051127134735.GK31722@brahms.suse.de>
References: <1132789071.9460.16.camel@linuxchandra> <20051126200741.421a342a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126200741.421a342a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   - Introduce a new notifier API which is wholly unlocked

The old notifiers were already wholly unlocked. So it wouldn't 
even need any changes. Just additional locks everywhere.

I agree it's the cleaner implementation.

-Andi
