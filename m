Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUDOVaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbUDOV2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:28:25 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:24614 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263372AbUDOV2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:28:06 -0400
Date: Thu, 15 Apr 2004 23:36:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, jgarzik@pobox.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH] Kconfig.debug family
Message-ID: <20040415213614.GB2656@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Matt Mackall <mpm@selenic.com>, jgarzik@pobox.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <407CEB91.1080503@pobox.com> <20040414005832.083de325.akpm@osdl.org> <20040414010240.0e9f4115.akpm@osdl.org> <407CF201.408@pobox.com> <20040414011653.22c690d9.akpm@osdl.org> <407CFFF9.5010500@pobox.com> <20040414212539.GE1175@waste.org> <20040415135229.75964100.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415135229.75964100.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 01:52:29PM -0700, Randy.Dunlap wrote:
> On Wed, 14 Apr 2004 16:25:39 -0500 Matt Mackall wrote:
> 
> | Sticking this in arch/*/Kconfig seems silly (as does much of the
> | duplication in said files). Can we stick this and other debug bits
> | under the kallsyms option in init/Kconfig instead? Or alternately move
> | debugging bits into their own file that gets included as appropriate.
> 
> 
> This patch:
> - creates lib/Kconfig.debug for generic kernel debug options
> - creates arch/*/Kconfig.debug for arch-specific debug options
> - moves KALLSYMS to the generic kernel debug options list
> 
> 
> This is a first cut for review/comments.  I will double-check
> the generic options list to see how it needs to be corrected...

Looks good to me - and I really like concentrating this in
a more logic common place.

If you could move even more to the generic part it would be fine.

	Sam
