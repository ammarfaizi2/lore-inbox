Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVELVa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVELVa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVELVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:30:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19720 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262132AbVELV3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:29:19 -0400
Date: Thu, 12 May 2005 23:29:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs doesn't work even with docbook stylesheets installed
Message-ID: <20050512212918.GA3603@stusta.de>
References: <20050512120358.GA8126@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512120358.GA8126@kestrel>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 02:03:58PM +0200, Karel Kulhavy wrote:
> make htmldocs says thast docbook stylesheets are not installed while
> they are:
> 
> kestrel linux-2.6.11.9 # make htmldocs
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   DOCPROC Documentation/DocBook/wanbook.sgml
> *** You need to install DocBook stylesheets ***
> make[1]: *** [Documentation/DocBook/wanbook.html] Error 1
> make: *** [htmldocs] Error 2
> kestrel linux-2.6.11.9 # emerge -s stylesheet
> Searching...   
> [ Results for search key : stylesheet ]
> [ Applications found : 2 ]
>  
> *  app-text/docbook-dsssl-stylesheets
>       Latest version available: 1.77-r2
>       Latest version installed: 1.77-r2
>       Size of downloaded files: 385 kB
>       Homepage:    http://docbook.sourceforge.net
>       Description: DSSSL Stylesheets for DocBook.
>       License:     as-is
> 
> *  app-text/docbook-xsl-stylesheets
>       Latest version available: 1.66.1
>       Latest version installed: 1.66.1
>       Size of downloaded files: 1,514 kB
>       Homepage:    http://docbook.sourceforge.net/
>       Description: XSL Stylesheets for Docbook
>       License:     || ( as-is BSD )
> 
> Is this a bug in Linux make htmldocs?


It sounds more like you are missing a package.

In Debian it's called "docbook-utils", I don't know whether it has the 
same name in Gentoo.


> CL<

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

