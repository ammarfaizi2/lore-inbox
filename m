Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270001AbUJTIYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270001AbUJTIYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUJTIX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:23:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47110 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270213AbUJTIFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:05:08 -0400
Date: Wed, 20 Oct 2004 09:05:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove last reference to LDFLAGS_BLOB
Message-ID: <20041020090501.C1047@flint.arm.linux.org.uk>
Mail-Followup-To: Brian Gerst <bgerst@quark.didntduck.org>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <4175C6E2.1080201@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4175C6E2.1080201@quark.didntduck.org>; from bgerst@quark.didntduck.org on Tue, Oct 19, 2004 at 10:01:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 10:01:06PM -0400, Brian Gerst wrote:
> Nothing uses LDFLAGS_BLOB anymore, now that the arm binutils are fixed.

No it hasn't.  We still have problems with ARM binutils.  As I said
at the time, forcing us to upgrade _will_ cause major problems.

Essentially, all ARM binutils post 2.11.90 to date remain broken in
one way or another.

I should've been stronger to veto the obsolescence of 2.11.90 for
kernel building.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
