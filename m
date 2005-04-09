Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVDIAEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVDIAEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 20:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDIAEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 20:04:11 -0400
Received: from waste.org ([216.27.176.166]:40892 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261207AbVDIAEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 20:04:08 -0400
Date: Fri, 8 Apr 2005 17:03:56 -0700
From: Matt Mackall <mpm@selenic.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: domen@coderock.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       didickman@yahoo.com
Subject: Re: [patch 2/8] correctly name the Shell sort
Message-ID: <20050409000356.GM25554@waste.org>
References: <20050408075054.25DF41F3A3@trashy.coderock.org> <200504081552.j38FqBCH012050@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504081552.j38FqBCH012050@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 11:52:10AM -0400, Horst von Brand wrote:
> domen@coderock.org said:
> 
> > As per http://www.nist.gov/dads/HTML/shellsort.html, this should be
> > referred to as a Shell sort. Shell-Metzner is a misnomer.
> 
> > Signed-off-by: Daniel Dickman <didickman@yahoo.com>
> > Signed-off-by: Domen Puncer <domen@coderock.org>
> 
> Why not use the sort routine from lib/sort.c?

Because the groups are not in an array. They're in a bunch of
page-sized blocks and the indexing function knows how to look at the
index block and make everything look like an array from the point of
view of the shell sort. I couldn't come up with a clean way to handle
it.

-- 
Mathematics is the supreme nostalgia of our time.
