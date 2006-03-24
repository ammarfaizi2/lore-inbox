Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWCXPs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWCXPs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWCXPs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:48:26 -0500
Received: from cantor2.suse.de ([195.135.220.15]:13777 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751115AbWCXPsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:48:25 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in thee820 table
Date: Fri, 24 Mar 2006 16:48:19 +0100
User-Agent: KMail/1.9.1
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <1143138170.3147.43.camel@laptopd505.fenrus.org> <200603241639.54192.ak@suse.de> <44241359.3070409@linux.intel.com>
In-Reply-To: <44241359.3070409@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241648.19901.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 16:42, Arjan van de Ven wrote:
> Andi Kleen wrote:
> > In theory they should be the same. What do you think is different?
> 
> in practice the x86-64 version returns "success" if there is one byte in the entire
> memory range that complies with the requested type, even if the rest of the range is
> of another type. 

I would consider that a bug. Please send fix.

-Andi
