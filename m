Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbUB1Mwa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 07:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUB1Mwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 07:52:30 -0500
Received: from ns.suse.de ([195.135.220.2]:4824 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261831AbUB1Mw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 07:52:29 -0500
To: olof@austin.ibm.com
Cc: torvalds@osdl.org, benh@kernel.crashing.org,
       <linux-kernel@vger.kernel.org>, <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: [PATCH] ppc64: Add iommu=on for enabling DART on small-mem machines
References: <Pine.A41.4.44.0402271524190.43108-100000@forte.austin.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Feb 2004 13:52:27 +0100
In-Reply-To: <Pine.A41.4.44.0402271524190.43108-100000@forte.austin.ibm.com.suse.lists.linux.kernel>
Message-ID: <p73ad334b90.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

olof@austin.ibm.com writes:

> Linus,
> 
> Below patch makes it possible for people like me with a small-mem G5 to
> enable the DART. I see two reasons for wanting to do so:

Could you call it iommu=force ? 

It would be the same name as on x86-64 for the same thing then and
a consistent name may be easier to get to driver developers.

-Andi
