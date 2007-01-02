Return-Path: <linux-kernel-owner+w=401wt.eu-S1754777AbXABAzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbXABAzK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbXABAzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:55:10 -0500
Received: from xenotime.net ([66.160.160.81]:34917 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754777AbXABAzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:55:09 -0500
Date: Mon, 1 Jan 2007 16:41:47 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: tali@admingilde.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DocBook/HTML: Generate chapter/section level TOCs for
 functions
Message-Id: <20070101164147.3a6da015.rdunlap@xenotime.net>
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
> 
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

Hi,
Is it possible to make the TOC contain active links to their
sections/functions?  That would be even better, wouldn't it?

---
~Randy
