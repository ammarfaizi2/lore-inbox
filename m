Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVFPUmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVFPUmG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFPUmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:42:05 -0400
Received: from dilbert.robsims.com ([209.120.158.98]:62985 "EHLO
	mail.robsims.com") by vger.kernel.org with ESMTP id S261714AbVFPUl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:41:58 -0400
Date: Thu, 16 Jun 2005 14:41:57 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050616204157.GB23942@robsims.com>
References: <f192987705061303383f77c10c@mail.gmail.com> <20050615212825.GS23621@csclub.uwaterloo.ca> <42B0BAF5.106@poczta.fm> <200506152144.56540.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506152144.56540.pmcfarland@downeast.net>
User-Agent: Mutt/1.5.9i
From: robsims@robsims.com (Rob Sims)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 09:44:55PM -0400, Patrick McFarland wrote:
> > I've tried cd packet writing with UDF and it gives insane overhead of
> > about 20%. What metadata you'd like to store for example on your
> > flashdrive or a floppy disk?
> 
> Uh, 20%? That sounds awfully high. You sure you didn't do something wrong?

Fixed packet recording under UDF records data in 32/39 of sectors; this
alone is 18%; I can easily see 2% in UDF itself.

More specifically, each packet has a seven sector overhead.  UDF sets
the packet size to 32.
-- 
Rob
