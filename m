Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291844AbSBAQrZ>; Fri, 1 Feb 2002 11:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291845AbSBAQrP>; Fri, 1 Feb 2002 11:47:15 -0500
Received: from zero.tech9.net ([209.61.188.187]:44561 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291844AbSBAQrF>;
	Fri, 1 Feb 2002 11:47:05 -0500
Subject: Re: Continuing /dev/random problems with 2.4
From: Robert Love <rml@tech9.net>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Feb 2002 11:53:20 -0500
Message-Id: <1012582401.813.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-01 at 04:17, Ken Brownfield wrote:

> Robert Love did some /dev/random maintenance a while back, and his
> netdev patches are essential for low disk-activity systems.  While his
> patches have helped the situation greatly, it appears that there is
> something in the random code that can cause extraction of entropy to
> permanently exhaust the pool.  Some kind of issue when entropy is near
> zero at the time of a read?

Most of the useful fixes actually came in a large update from Andreas
Dilger.  Perhaps he would have some insight, too.

Exhausting entropy to zero under high use is not uncommon (that is a
motivation for my netdev-random patch).  What boggles me is why it does
not regenerate?

	Robert

