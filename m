Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTFYMan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 08:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTFYMam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 08:30:42 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:3851 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264115AbTFYMai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 08:30:38 -0400
Date: Wed, 25 Jun 2003 14:44:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Stewart Smith <stewart@linux.org.au>
cc: trivial@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [trivial 2.5] kconfig language doc r.e. --help--
In-Reply-To: <20030625112534.GB9295@cancer>
Message-ID: <Pine.LNX.4.44.0306251443100.11817-100000@serv>
References: <20030625084309.GA9295@cancer> <Pine.LNX.4.44.0306251246240.11817-100000@serv>
 <20030625112534.GB9295@cancer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 Jun 2003, Stewart Smith wrote:

> --- linux-2.5.73/Documentation/kbuild/kconfig-language.txt	2003-06-15 17:47:18.000000000 +1000
> +++ linux-2.5.73-stew1/Documentation/kbuild/kconfig-language.txt	2003-06-25 21:24:28.000000000 +1000
> @@ -105,10 +105,13 @@
>    or equal to the first symbol and smaller than or equal to the second
>    symbol.
>  
> -- help text: "help"
> +- help text: "help" or "---help---"
>    This defines a help text. The end of the help text is determined by
>    the indentation level, this means it ends at the first line which has
>    a smaller indentation than the first line of the help text.
> +  "---help---" and "help" do not differ in behaviour, "---help---" is
> +  used to help visually seperate configuration logic from help within
> +  the file as an aid to developers.

Looks fine, thanks.

bye, Roman

