Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752075AbWIHEAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWIHEAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWIHEAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:00:21 -0400
Received: from nef2.ens.fr ([129.199.96.40]:47878 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1752075AbWIHEAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:00:20 -0400
Date: Fri, 8 Sep 2006 06:00:06 +0200
From: David Madore <david.madore@ens.fr>
To: James Antill <james@and.org>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908040006.GA24135@clipper.ens.fr>
References: <20060905212643.GA13613@clipper.ens.fr> <m3r6yn4jxg.fsf@code.and.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3r6yn4jxg.fsf@code.and.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 06:00:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 02:21:15PM -0400, James Antill wrote:
>  Just a minor comment, can you break out the OPEN into at least
> OPEN_R, OPEN_NONFILE_W and OPEN_W (possibly OPEN_A, but I don't want
> that personally).

Version 0.4.2 of the patch, which I'm about to post to the list, adds
a CAP_REG_WRITE capability that is supposed to prevent any write
operation to the filesystem.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
