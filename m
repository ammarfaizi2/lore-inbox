Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUIVENK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUIVENK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 00:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUIVENJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 00:13:09 -0400
Received: from peabody.ximian.com ([130.57.169.10]:33924 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267841AbUIVENH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 00:13:07 -0400
Subject: Re: Does ZONE_HIGHMEM exist on machines with 1G memeory
From: Robert Love <rml@novell.com>
To: Ronghua Zhang <rz5b@cs.virginia.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.51.0409212305520.8395@mamba.cs.Virginia.EDU>
References: <Pine.GSO.4.51.0409212305520.8395@mamba.cs.Virginia.EDU>
Content-Type: text/plain
Date: Wed, 22 Sep 2004 00:13:07 -0400
Message-Id: <1095826387.2454.101.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 23:09 -0400, Ronghua Zhang wrote:

>   This may be a dumb question. But it seems to me that when the machine
> has 1GB memory, it can be mapped to the 1GB kernel virtual address space.
> Do we still need ZONE_HIGHMEM in this case? Please CC any follow-up to me.
> Thanks

Highmem is actually everything above 896MB ... so, yes, you need
ZONE_HIGHMEM.

	Robert Love


