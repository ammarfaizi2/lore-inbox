Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUAOWCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUAOWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:02:06 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:45959 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262960AbUAOWCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:02:02 -0500
To: "Brown, Len" <len.brown@intel.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>, "Jesse Barnes" <jbarnes@sgi.com>
Subject: Re: [patch] 2.6.1-mm3 acpi frees free irq0
References: <BF1FE1855350A0479097B3A0D2A80EE0CC89CC@hdsmsx402.hd.intel.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 15 Jan 2004 17:01:51 -0500
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC89CC@hdsmsx402.hd.intel.com>
Message-ID: <yq0d69k27n4.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Len" == Brown, Len <len.brown@intel.com> writes:

Len> The primary failure is that the SCI was not found, and the
Len> secondary symptom is that we failed to handle that error properly
Len> -- which you've patched.

Len> Can you tell me more about the primary failure?  Was the SCI
Len> found in other releases?

Hi Len,

In this specific case the prom doesn't have it in it's tables, so not
finding it is expected behavior.

Cheers,
Jes
