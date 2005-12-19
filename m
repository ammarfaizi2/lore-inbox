Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbVLSGm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbVLSGm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 01:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVLSGm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 01:42:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:6370 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965253AbVLSGm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 01:42:28 -0500
Subject: Re: cpu hotplug oops on 2.6.15-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sonny Rao <sonny@burdell.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, clameter@sgi.com,
       anton@samba.org, sonnyrao@us.ibm.com
In-Reply-To: <20051219051659.GA6299@kevlar.burdell.org>
References: <20051219051659.GA6299@kevlar.burdell.org>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 17:41:57 +1100
Message-Id: <1134974518.10035.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 00:16 -0500, Sonny Rao wrote:
> (apologies if this is a dup)
> 
> Hi, I'm crashing 2.6.15-rc5 when I try and offline the last and only CPU in a node on a ppc64 Power5, SMT was disabled.

First try on -rc6 just in case it's related to the SCSI fix (the bug was
corrupting the SLAB) that got merged just after rc5 iirc.

Ben.




