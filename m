Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWCJBV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWCJBV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbWCJBVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:21:24 -0500
Received: from ns1.suse.de ([195.135.220.2]:2710 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932119AbWCJBVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:21:22 -0500
From: Andi Kleen <ak@muc.de>
To: Kevin Winchester <kwin@ns.sympatico.ca>
Subject: Re: [PATCH -mm3] x86-64: Eliminate register_die_notifier symbol exported twice
Date: Thu, 9 Mar 2006 18:48:15 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <4410BDFB.3070401@ns.sympatico.ca>
In-Reply-To: <4410BDFB.3070401@ns.sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603091848.15590.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 March 2006 00:44, Kevin Winchester wrote:
> 
> register_die_notifier is exported twice, once in traps.c and once in 
> x8664_ksyms.c.  This results in a warning on build.
> 
> Signed-Off-By: Kevin Winchester <kwin@ns.sympatico.ca>

Applied. Thanks.
-Andi

 
