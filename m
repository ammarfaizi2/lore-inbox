Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275277AbTHSBJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275278AbTHSBJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:09:53 -0400
Received: from waste.org ([209.173.204.2]:38812 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275277AbTHSBJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:09:52 -0400
Date: Mon, 18 Aug 2003 20:09:43 -0500
From: Matt Mackall <mpm@selenic.com>
To: Dave Jones <davej@redhat.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-ID: <20030819010943.GG16387@waste.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org> <20030815173246.GB9681@redhat.com> <20030815123053.2f81ec0a.rddunlap@osdl.org> <20030816070652.GG325@waste.org> <20030818140729.2e3b02f2.rddunlap@osdl.org> <20030819001316.GF22433@redhat.com> <20030819010119.GF16387@waste.org> <20030819010457.GG22433@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819010457.GG22433@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 02:04:57AM +0100, Dave Jones wrote:
> On Mon, Aug 18, 2003 at 08:01:19PM -0500, Matt Mackall wrote:
>  > > 
>  > > By the looks of the logs, it happened as I restarted X, as theres
>  > > a bunch of mtrr messages right after this..
>  > 
>  > What video driver do you use?
> 
> mga

I had someone else send me a strings(1) of that driver, and it looked
like it was running a copy of its BIOS.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
