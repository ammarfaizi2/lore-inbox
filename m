Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265251AbUETWeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUETWeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUETWeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:34:09 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:63476 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265251AbUETWeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:34:07 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
Date: Thu, 20 May 2004 18:33:28 -0400
User-Agent: KMail/1.6.2
Cc: davidm@hpl.hp.com, hch@infradead.org, linux-kernel@vger.kernel.org
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de> <200405201810.48141.jbarnes@engr.sgi.com> <20040520152510.02de52a1.akpm@osdl.org>
In-Reply-To: <20040520152510.02de52a1.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405201833.28362.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 20, 2004 6:25 pm, Andrew Morton wrote:
> Me no understand Jesse.
>
> Removing the ifdefs and letting the linker do the job has the advantage
> that the compiler gets to check more code for you.

Nevermind, I was confused about the patch.  I thought (without looking at it) 
that arch versions would be hidden in arch code, but now I see that they're 
just completely unused, so there's little chance for confusion.  I'll shut up 
now.

Jesse
