Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUKCVHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUKCVHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUKCVHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:07:20 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:7074 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261889AbUKCVFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:05:47 -0500
Date: Wed, 3 Nov 2004 13:05:16 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info
Message-ID: <20041103210516.GB10756@taniwha.stupidest.org>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com.suse.lists.linux.kernel> <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com.suse.lists.linux.kernel> <p733bzr8qf2.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p733bzr8qf2.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 06:14:41AM +0100, Andi Kleen wrote:

> Please don't do that. At least on i386/x86-64 we want the same
> code with debug info as without. Otherwise how would you debug
> a problem that only shows up at -O2.

this is true for all architectures really (unless there is a platform
where gcc is perfect and completely bug free)
