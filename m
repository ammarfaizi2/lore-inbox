Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965547AbWIRILG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965547AbWIRILG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965546AbWIRILG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:11:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58007 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965547AbWIRILE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:11:04 -0400
Subject: Re: [patch 1/8] extend make headers_check to detect more problems
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200609181005.36817.arnd@arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
	 <20060918013216.335200000@klappe.arndb.de>
	 <20060918062152.GA7088@uranus.ravnborg.org>
	 <200609181005.36817.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 09:10:41 +0100
Message-Id: <1158567041.24527.310.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 10:05 +0200, Arnd Bergmann wrote:
> 
> +headers-y    Files that are installed verbatim from the source
> +            directory, as well subdirectories that also contain
> +            installable header files.
> +objhdr-y     Files that are installed from the object directory,
> +            having been generated during the kernel build.
> +unifdef-y    Files that have both parts for installations and
> +            parts that are private to the kernel. These files
> +            are run through the 'unifdef'(1) program that will
> +            strip all parts inside of '#ifdef __KERNEL__'.

 objhdr-y      Files that are generated automatically during the
               build process (i.e. include/linux/version.h) and
               are installed verbatim from the build directory.

Looks good, thanks for doing the documentation.

-- 
dwmw2

