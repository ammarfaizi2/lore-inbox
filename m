Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269701AbUJGFXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269701AbUJGFXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269702AbUJGFXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:23:08 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:54033 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269701AbUJGFXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:23:05 -0400
Date: Thu, 7 Oct 2004 07:22:24 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [Patch] share i386/x86_64 intel cache descriptors table
Message-ID: <20041007052224.GD19761@alpha.home.local>
References: <20041006184723.A10900@unix-os.sc.intel.com> <4164B71A.30105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4164B71A.30105@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Wed, Oct 06, 2004 at 11:25:14PM -0400, Jeff Garzik wrote:
> I have often wondered if there is any value to creating arch/x86 and 
> include/asm-x86 for stuff shared between x86-64 and i386.

I came to the same conclusion a week ago when I realized that a patched
kernel did not compile on an opteron because of the exact same things I
had already fixed on i386 a few days before. Probably we could have a
generic x86 branch, with currently two variants : i386 and x86_64 ? I
don't know how to arrange this, though...

> All this #include and cross-linking stuff gives me the willys...

Hmmm... What do you have against the willys ? ;-)

Willy

