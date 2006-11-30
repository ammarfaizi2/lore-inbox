Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967732AbWK3AcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967732AbWK3AcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967734AbWK3AcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:32:03 -0500
Received: from ns.suse.de ([195.135.220.2]:43710 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S967732AbWK3AcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:32:01 -0500
From: Andi Kleen <ak@suse.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] alternatives/paravirt: use NULL for pointers
Date: Thu, 30 Nov 2006 01:31:54 +0100
User-Agent: KMail/1.9.5
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20061129131708.ebbdd36c.randy.dunlap@oracle.com>
In-Reply-To: <20061129131708.ebbdd36c.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300131.55047.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 November 2006 22:17, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Use NULL instead of 0 for pointers.
> 
> arch/x86_64/kernel/../../i386/kernel/alternative.c:432:18: warning: Using plain integer as NULL pointer
> arch/x86_64/kernel/../../i386/kernel/alternative.c:432:44: warning: Using plain integer as NULL pointer

I fixed it in the original patch thanks

-Andi
