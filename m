Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUCLKL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUCLKL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:11:26 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:5041 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261748AbUCLKLT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:11:19 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: "Yury V. Umanets" <umka@namesys.com>
Subject: Re: About Replaceable OOM Killer
Date: Fri, 12 Mar 2004 11:15:12 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, "Guo, Min" <min.guo@intel.com>,
       cgl_discussion@lists.osdl.org
References: <3ACA40606221794F80A5670F0AF15F84035F1DD5@PDSMSX403.ccr.corp.intel.com> <200403011141.26724.tvrtko@croadria.com> <1078403388.3025.33.camel@firefly>
In-Reply-To: <1078403388.3025.33.camel@firefly>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403121115.12518.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 March 2004 13:29, Yury V. Umanets wrote:
> IMHO problem with OOM killer is that it always will do wrong choice. So,
> it should be either plugin based or allow to configure it and this
> means, that it will become more complex and buggy. Does not it mean,
> that OOM killer should be moved to user space?
>
> How about to export OOM event to user space? It might be done in manner
> like hotplug script is used.

No, I don't think userspace is a good idea.

On the other hand... I have updated the MOOM patch in sync with 2.4.25, you 
can get it at http://linux.ursulin.net or from LKML.

Any comments, bug reports, etc are welcomed!

-- 
Best regards,
Tvrtko A. Ur¹ulin, Linux admin 
--
Croadria Internet usluge <http://www.croadria.com>
- Web hosting (Linux & Windows), E-commerce
