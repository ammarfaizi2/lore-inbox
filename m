Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWEIQpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWEIQpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWEIQpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:45:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:12448 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750704AbWEIQpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:45:22 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Date: Tue, 9 May 2006 18:42:35 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085145.790527000@sous-sol.org>
In-Reply-To: <20060509085145.790527000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091842.35957.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 09:00, Chris Wright wrote:
> The XEN config option is selected from the i386 subarch menu by
> choosing the X86_XEN "Xen-compatible" subarch.

I really dislike all these negative option checks.

I think it would be better if you defined a positive symbol like
BARE_METAL (better name?)and define that only for the non XEN case.

-Andi
