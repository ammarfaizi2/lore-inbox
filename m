Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVFWLb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVFWLb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 07:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVFWLb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 07:31:58 -0400
Received: from ns1.suse.de ([195.135.220.2]:18408 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262250AbVFWLbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 07:31:52 -0400
Date: Thu, 23 Jun 2005 13:31:50 +0200
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 prefetchw() function can take into account CONFIG_MK8 / CONFIG_MPSC
Message-ID: <20050623113150.GK14251@wotan.suse.de>
References: <20050622.132241.21929037.davem@davemloft.net> <200506222242.j5MMgbxS009935@guinness.s2io.com> <20050622231300.GC14251@wotan.suse.de> <42BA81B2.4070108@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BA81B2.4070108@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 11:32:34AM +0200, Eric Dumazet wrote:
> If we build a x86_64 kernel for an AMD64 or for an Intel EMT64, no need to 
> use alternative_input.
> Reserve alternative_input only for a generic kernel.

An EM64T kernel should still boot on AMD64 and vice versa. Rejected.

-Andi
