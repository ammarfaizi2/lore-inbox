Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937597AbWLFUJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937597AbWLFUJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937596AbWLFUJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:09:13 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:41475 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937594AbWLFUJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:09:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=O1rz99c1K7t0PDs4a8gNLjfIl9SDydVz9EK+Zk+cjpIIbCktGq0Qtx9Us82+b
	+m7wwDUEPFZOQ1xkU1+pufXtA==
Date: Wed, 6 Dec 2006 21:09:09 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206200909.GB5481@xi.wantstofly.org>
References: <20061206191252.GH32748@xi.wantstofly.org> <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <28668.1165434442@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28668.1165434442@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 07:47:22PM +0000, David Howells wrote:

> > > Pre-v6 ARM doesn't support SMP according to ARM's atomic.h,
> > 
> > That's not quite true, there exist ARMv5 processors that in theory
> > can support SMP.
> 
> I meant that the Linux ARM arch doesn't support it:

Ah, yes, not currently.  That's true.
