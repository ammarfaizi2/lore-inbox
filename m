Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267603AbUIAUIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267603AbUIAUIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267605AbUIAUIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:08:53 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:50733 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267603AbUIAUIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:08:51 -0400
Date: Wed, 1 Sep 2004 22:11:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] Set-cflags-before-including-arch-Makefile
Message-ID: <20040901201102.GC15432@mars.ravnborg.org>
Mail-Followup-To: blaisorblade_spam@yahoo.it, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040830194838.3F2B37D87@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830194838.3F2B37D87@zion.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 09:48:38PM +0200, blaisorblade_spam@yahoo.it wrote:
> 
> Please note that this patch, even if UML-related, should be immediately
> discussed for merging in mainline, if possible. The UML patch to handle
> this has therefore been separated.
> 
> ---Patch purpose:
> If arch/$(ARCH)/Makefile is included before adding -O2 (and the rest) to
> CFLAGS, I must duplicate the addition of it to USER_CFLAGS for UML.
> So let's fix this.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---

Thanks - applied.

	Sam
