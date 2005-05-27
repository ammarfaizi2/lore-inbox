Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVE0A12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVE0A12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 20:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVE0A12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 20:27:28 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:36029 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261861AbVE0A1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 20:27:25 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 7/7] UML - Remove unused code
Date: Fri, 27 May 2005 02:29:14 +0200
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200505262230.j4QMUZDf014704@ccure.user-mode-linux.org>
In-Reply-To: <200505262230.j4QMUZDf014704@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505270229.16223.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 00:30, Jeff Dike wrote:
> This removes two now unused files and a couple of unused functions.  The
> files were removed by quilt add $file; rm $file; quilt refresh.  If that
> doesn't do it, I don't know what to do :-)
Be careful with this patch, since from the header timestamp I guess it won't 
remove the file... do it by hand yourself when committing it.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>

> Index: linux-2.6.11/arch/um/kernel/initrd_kern.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/initrd_kern.c	2005-05-26
> 17:15:14.000000000 -0400 +++
> linux-2.6.11/arch/um/kernel/initrd_kern.c	2003-09-15 09:40:47.000000000
This should be 1970 to remove the file IIRC.

> Index: linux-2.6.11/arch/um/kernel/initrd_user.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/initrd_user.c	2005-05-26
> 17:15:14.000000000 -0400 +++
> linux-2.6.11/arch/um/kernel/initrd_user.c	2003-09-15 09:40:47.000000000
> -0400 @@ -1,46 +0,0 @@
Same for this.

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
