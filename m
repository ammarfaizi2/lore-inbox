Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263534AbUJ2Uhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbUJ2Uhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUJ2UeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:34:09 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:52229 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S263485AbUJ2UWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:22:32 -0400
Date: Fri, 29 Oct 2004 21:22:14 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop IRDA ISA dependency
Message-ID: <20041029202214.GC18508@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20041029130846.3D6639DF0EA9@verdi.suse.de> <20041029134549.GA12705@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029134549.GA12705@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:45:49PM +0100, Christoph Hellwig wrote:
 
 > but this is bogus.  If it's using isa-style DMA it needs CONFIG_ISA.

Sounds like there is some confusion over what CONFIG_ISA means.
I always understood it to mean 'We have ISA slots on this architecture'
regardless of whether theres an ISA style LPC bus.
Its a means of disabling a whole slew of drivers that have no
meaning on a particular platform (in Andi's case, x86-64).

Or did I get confused ?

		Dave

