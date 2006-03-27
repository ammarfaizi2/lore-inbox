Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWC0R1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWC0R1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWC0R1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:27:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:21404 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750775AbWC0R1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:27:47 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] x86_64: extra NODES_SHIFT definition
Date: Mon, 27 Mar 2006 19:14:54 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060327171207.B17D7C47@localhost.localdomain>
In-Reply-To: <20060327171207.B17D7C47@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603271914.55349.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 March 2006 19:12, Dave Hansen wrote:
> 
> The generic linux/numa.h file defines NODES_SHIFT to 0 in case
> the architecture did not.
> 
> Every architecture which has a NUMA config option defines
> NODES_SHIFT in its asm-$ARCH headers, but only if NUMA is
> enabled, except for x86_64.
> 
> This should make it like all the rest.


Applied thanks.
-Andi
