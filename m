Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTJACvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 22:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTJACvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 22:51:47 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:25734 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261879AbTJACvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 22:51:46 -0400
Date: Wed, 1 Oct 2003 03:51:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001025128.GD32209@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCE@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AFCE@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> Oh, I thought you already closed this issue and you were discussing a
> different thing.
> 
> I agree. They kernel should fix up userspace for this CPU errata.

Our question is whether kernels configured specifically for non-AMD
(e.g. Winchip or Elan kernels) must have the AMD fixup code (it is a
few hundred bytes), refuse to boot on AMD, ignore the problem, or work
but not fix up userspace.

-- Jamie
