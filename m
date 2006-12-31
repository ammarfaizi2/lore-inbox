Return-Path: <linux-kernel-owner+w=401wt.eu-S932948AbWLaFt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbWLaFt5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 00:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbWLaFt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 00:49:57 -0500
Received: from xenotime.net ([66.160.160.81]:38312 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932948AbWLaFt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 00:49:56 -0500
Date: Sat, 30 Dec 2006 21:36:28 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: tali@admingilde.org, linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: Re: [PATCH] DocBook/HTML: Generate chapter/section level TOCs for
 functions
Message-Id: <20061230213628.76c22d13.rdunlap@xenotime.net>
In-Reply-To: <200612310227.47721.pisa@cmp.felk.cvut.cz>
References: <200612310227.47721.pisa@cmp.felk.cvut.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006 02:27:46 +0100 Pavel Pisa wrote:

> Simple increase of section TOC level generation significantly
> enhances navigation experience through generated kernel
> API documentation.
> 
> This change restores back state from SGML tools time.
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Andrew, please put this into -mm for testing.


> Index: linux-2.6.19/Documentation/DocBook/stylesheet.xsl
> ===================================================================
> --- linux-2.6.19.orig/Documentation/DocBook/stylesheet.xsl
> +++ linux-2.6.19/Documentation/DocBook/stylesheet.xsl
> @@ -4,4 +4,5 @@
>  <param name="funcsynopsis.style">ansi</param>
>  <param name="funcsynopsis.tabular.threshold">80</param>
>  <!-- <param name="paper.type">A4</param> -->
> +<param name="generate.section.toc.level">2</param>
>  </stylesheet>
> -

---
~Randy
