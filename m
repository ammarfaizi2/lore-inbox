Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVCPETU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVCPETU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVCPETT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:19:19 -0500
Received: from waste.org ([216.27.176.166]:52669 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262234AbVCPETR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:19:17 -0500
Date: Tue, 15 Mar 2005 20:19:12 -0800
From: Matt Mackall <mpm@selenic.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050316041912.GT32638@waste.org>
References: <4235BC29.2060009@lougher.demon.co.uk> <20050315031251.GI3163@waste.org> <42376ED3.4090502@lougher.demon.co.uk> <20050316010432.GS32638@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316010432.GS32638@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 05:04:32PM -0800, Matt Mackall wrote:
> On Tue, Mar 15, 2005 at 11:25:07PM +0000, Phillip Lougher wrote:
> > >>+	unsigned int		s_major:16;
> > >>+	unsigned int		s_minor:16;
> > >
> > >What's going on here? s_minor's not big enough for modern minor
> > >numbers.
> > 
> > What is the modern size then?
> 
> Minors are 22 bits, majors are 10. May grow to 32 each at some point.

Both akpm and I remembered wrong, fyi. It's 12 major bits, 20 minor.

-- 
Mathematics is the supreme nostalgia of our time.
