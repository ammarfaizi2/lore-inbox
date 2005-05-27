Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVE0VTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVE0VTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVE0VTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 17:19:40 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:57469 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262600AbVE0VTT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 17:19:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MYUzfs75T0wmUhuE7vc2CkglFSAMn/X8JeLseqdtURX/3/IuhwNQgFEAgV5Rw+qVwwZUxWCQRxl1XQ8RFSzgRsf4peKN84KNI4GIXz+xrq1+RYS13OyqfxI2EYNtPBw3Du61flz1Tkk5jmNCB2+nT0wyDy0Pm7g2gXHeGD1HPAc=
Message-ID: <d4dc44d505052714193e2c1d1@mail.gmail.com>
Date: Fri, 27 May 2005 23:19:13 +0200
From: Schneelocke <schneelocke@gmail.com>
Reply-To: Schneelocke <schneelocke@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ALSA official git repository
Cc: Linus Torvalds <torvalds@osdl.org>, perex@suse.cz,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
In-Reply-To: <20050527135124.0d98c33e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
	 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
	 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
	 <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
	 <20050527135124.0d98c33e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/05, Andrew Morton <akpm@osdl.org> wrote:
> Yes, I'll occasionally do patches which were written by "A" as:
> 
> From: A
> ...
> Signed-off-by: B
> 
> And that comes through email as:
> 
> ...
> From: <akpm@osdl.org>
> ...
> From: A
> ...
> Signed-off-by: B
> 
> which means that the algorithm for identifying the author is "the final
> From:".
> 
> I guess the bug here is the use of From: to identify the primary author,
> because transporting the patch via email adds ambiguity.
> 
> Maybe we should introduce "^Author:"?

How about "^Written-by:"? That seems to fit in much more nicely with
"Signed-off-by:".
 
-- 
schnee
