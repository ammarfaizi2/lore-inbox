Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWHCDzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWHCDzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWHCDzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:55:47 -0400
Received: from mail.suse.de ([195.135.220.2]:45791 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932197AbWHCDzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:55:46 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Date: Thu, 3 Aug 2006 05:55:34 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Lameter <clameter@sgi.com>, Zachary Amsden <zach@vmware.com>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <44D14ECC.3080600@vmware.com> <Pine.LNX.4.64.0608021821350.26404@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608021821350.26404@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030555.34569.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 03:25, Christoph Lameter wrote:

> Good idea. This will also make it easier to support this special 
> functionality. And it will avoid use in contexts where these are
> not necessary.

I think it's a bad idea. We don't want lots of architecture ifdefs
in some Xen specific file

-Andi
