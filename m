Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWCVPD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWCVPD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWCVPDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:37 -0500
Received: from mail.suse.de ([195.135.220.2]:2720 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751272AbWCVPDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:30 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 13/35] Support loading an initrd when running on Xen
Date: Wed, 22 Mar 2006 15:22:54 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063750.631016000@sorel.sous-sol.org>
In-Reply-To: <20060322063750.631016000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221522.54661.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:30, Chris Wright wrote:
> Due to the initial physical memory layout when booting on Xen, the initrd
> image ends up below min_low_pfn (as registered with the bootstrap memory
> allocator). Add an i386 build option to allow this scenario by setting
> the initrd_below_start_ok flag.

Better would be to just handle that by default without any CONFIGs.

-Andi
