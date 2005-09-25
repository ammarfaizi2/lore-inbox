Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVIYHiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVIYHiN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 03:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVIYHiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 03:38:13 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:2100 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751226AbVIYHiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 03:38:13 -0400
Date: Sun, 25 Sep 2005 09:38:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_IA32
Message-ID: <20050925073838.GA7591@mars.ravnborg.org>
References: <4335DD14.7090909@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4335DD14.7090909@didntduck.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] CONFIG_IA32
> 
> Add CONFIG_IA32 for i386.  This allows selecting options that only apply to
> 32-bit systems.
> 
> (X86 && !X86_64) becomes IA32
> (X86 ||  X86_64) becomes X86
>
...
>  mainmenu "Linux Kernel Configuration"
>  
> -config X86
> +config IA32
>  	bool
>  	default y
>  	help
Could you please add a comment here that say this is to allow one to
select 32 bit only dependencies.

	Sam
