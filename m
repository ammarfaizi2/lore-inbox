Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWCHNEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWCHNEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWCHNEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:04:42 -0500
Received: from mx1.suse.de ([195.135.220.2]:18596 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751788AbWCHNEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:04:41 -0500
From: Andi Kleen <ak@muc.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH] x86-64: free_bootmem_node needs __pa in allocate_aperture
Date: Wed, 8 Mar 2006 06:33:29 +0100
User-Agent: KMail/1.9.1
Cc: mulix@mulix.org, linux-kernel@vger.kernel.org
References: <20060307172651.GA26662@us.ibm.com>
In-Reply-To: <20060307172651.GA26662@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603080633.30086.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 18:26, Jon Mason wrote:
> free_bootmem_node expects a physical address to be passed in, but
> __alloc_bootmem_node returns a virtual one.  That address needs to be
> translated to physical.

Thanks applied. What a nasty trap.

-Andi
