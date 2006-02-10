Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWBJTrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWBJTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWBJTrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:47:16 -0500
Received: from mx1.suse.de ([195.135.220.2]:41106 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751326AbWBJTrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:47:16 -0500
Date: Fri, 10 Feb 2006 20:47:13 +0100
From: Olaf Hering <olh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060210194713.GA22599@suse.de>
References: <20060121180805.GA15761@suse.de> <20060121225728.GA13756@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060121225728.GA13756@mars.ravnborg.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 21, Sam Ravnborg wrote:


> +++ b/Makefile
> @@ -259,38 +259,6 @@ endif
>  
>  export quiet Q KBUILD_VERBOSE
>  
> -######
> -# cc support functions to be used (only) in arch/$(ARCH)/Makefile
> -# See documentation in Documentation/kbuild/makefiles.txt

> +++ b/scripts/Kbuild.include
> @@ -44,6 +44,43 @@ define filechk
>  	fi
>  endef
>  
> +######
> +# cc support functions to be used (only) in arch/$(ARCH)/Makefile
> +# See documentation in Documentation/kbuild/makefiles.txt

The comment needs updating.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
