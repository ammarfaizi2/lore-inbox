Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUGLQI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUGLQI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUGLQI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:08:28 -0400
Received: from chello212017098056.surfer.at ([212.17.98.56]:21776 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S265215AbUGLQI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:08:27 -0400
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200407121609.i6CG98W28473@hofr.at>
Subject: Re: TQM in 2.6.X
In-Reply-To: <20040712151937.GM28002@smtp.west.cox.net> from Tom Rini at "Jul
 12, 2004 08:19:37 am"
To: Tom Rini <trini@kernel.crashing.org>
Date: Mon, 12 Jul 2004 18:09:08 +0200 (CEST)
CC: Der Herr Hofrat <der.herr@hofr.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jul 11, 2004 at 11:48:54AM +0200, Der Herr Hofrat wrote:
> 
> >  arch/ppc/platforms/tqm8260_setup.c
> >  
> >  looks like it is truncated in the 2.6.X tar.bz2 archives from kernel.org
> >  (checked 2.6.0/5/6) - am I doing something stupid or is vanilla 2.6.X 
> >  just not ready for TQM8260 ?
> 
> The file is supposed to be short.  But yes, TQM8260 support has never been
> tested in 2.5 or 2.6, so there might be other problems lurking.
> 
> Andrew, please apply.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> --- 1.3/arch/ppc/platforms/tqm8260_setup.c	2004-06-16 10:56:13 -07:00
> +++ edited/tqm8260_setup.c	2004-07-12 08:17:30 -07:00
> @@ -77,3 +77,4 @@
>  
>  	callback_setup_arch	= ppc_md.setup_arch;
>  	ppc_md.setup_arch	= tqm8260_setup_arch;
> +}
>
I had tried that as it looked obvious - but that does not do it
will not compile with this change - so I assumed there is more missing...

thanks
hofrat 
