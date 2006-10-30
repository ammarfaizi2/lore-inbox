Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161401AbWJ3XMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161401AbWJ3XMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161425AbWJ3XMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:12:53 -0500
Received: from colin.muc.de ([193.149.48.1]:26130 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1161401AbWJ3XMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:12:53 -0500
Date: 31 Oct 2006 00:12:51 +0100
Date: Tue, 31 Oct 2006 00:12:51 +0100
From: Andi Kleen <ak@muc.de>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Message-ID: <20061030231251.GB98768@muc.de>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com> <200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com> <20061030225016.GA95732@muc.de> <45468620.5060805@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45468620.5060805@vmware.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is the one that can panic, for now.  Fixing the paravirtualized 
> case is easy, but we can't assume paravirtualization just yet.

Hmm, this means standard vmware boot is not reliable unless that magic option
is set?   That doesn't sound good.  

-Andi
