Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbREEQfB>; Sat, 5 May 2001 12:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132883AbREEQex>; Sat, 5 May 2001 12:34:53 -0400
Received: from mako.theneteffect.com ([63.97.58.10]:15633 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S132850AbREEQed>; Sat, 5 May 2001 12:34:33 -0400
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200105051634.LAA02026@mako.theneteffect.com>
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
To: cw@f00f.org (Chris Wedgwood)
Date: Sat, 5 May 2001 11:34:16 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010506033746.A30690@metastasis.f00f.org> from "Chris Wedgwood" at May 06, 2001 03:37:46 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Adding memory probably isn't going to be too hard... but taking
> existing memory off line is tricky. You have to find some way of
> finding all the pages that are in use and then dealing with them
> appropriately, and when some are locked or contain kernel data this
> would be extremely difficult I should think.

Wouldn't that be lot of the same issues as a "swapoff" with some portion of
that in use?  (except for the kernel data case of course...)

	M
