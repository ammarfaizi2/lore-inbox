Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268322AbUIGT30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268322AbUIGT30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268289AbUIGT2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:28:40 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:55812 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268322AbUIGT1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:27:15 -0400
Date: Tue, 7 Sep 2004 23:27:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, ". Sam Ravnborg" <sam@ravnborg.org>,
       Ian Wienand <ianw@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm4: small LOCALVERSION help text corrections
Message-ID: <20040907212716.GB6053@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, ". Sam Ravnborg" <sam@ravnborg.org>,
	Ian Wienand <ianw@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
References: <20040907020831.62390588.akpm@osdl.org> <20040907184314.GA2454@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907184314.GA2454@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 08:43:14PM +0200, Adrian Bunk wrote:
> On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
> >...
> >  bk-input.patch
> >...
> >  Latest versions of external trees
> >...
> 
> 
> Minor nitpicks:
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
> --- linux-2.6.9-rc1-mm4-full/init/Kconfig.old	2004-09-07 20:36:13.000000000 +0200
> +++ linux-2.6.9-rc1-mm4-full/init/Kconfig	2004-09-07 20:37:15.000000000 +0200
> @@ -311,13 +311,13 @@
>  config LOCALVERSION
>  	string "Local Version"
>  	help
>  	  Append an extra string to the end of your kernel version.
>  	  This will show up when you type uname, for example.
> -	  The string you set here will be appended after the contents of=20
> -	  any files with a filename matching localversion* in your=20
> -	  object and source tree, in that order.  Your total string can
> +	  The string you set here will be appended after the contents of
> +	  any files with a filename matching localversion* in your
> +	  object and source trees, in that order.  Your total string can
>  	  be a maximum of 64 characters.

Would it make sense to move this item further up in this menu?
I would prefer at the top, but at least before "Embedded"

	Sam
