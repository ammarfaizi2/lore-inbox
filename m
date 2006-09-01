Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWIAP33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWIAP33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWIAP33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:29:29 -0400
Received: from xenotime.net ([66.160.160.81]:53914 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751455AbWIAP32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:29:28 -0400
Date: Fri, 1 Sep 2006 08:32:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 02/22][RFC] Unionfs: Kconfig and Makefile
Message-Id: <20060901083247.39fc2ec8.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0609011444050.15283@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	<20060901013917.GC5788@fsl.cs.sunysb.edu>
	<Pine.LNX.4.61.0609011444050.15283@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 14:44:51 +0200 (MEST) Jan Engelhardt wrote:

> 
> >+config UNION_FS
> >+	tristate "Stackable namespace unification file system"
> >+	depends on EXPERIMENTAL
> >+	help
> >+	  Unionfs is a stackable unification file system, which appears to
> >+	  merge the contents of several directories (branches), while keeping
> >+	  their physical content separate.
> 
> Is there any CodingStyle for Kconfig files? Like what indentation to use (4 vs
> 8) (tab vs space) and/or whether to use "help" or "---help---"

Doc/kbuild/kconfig-language.txt says that "help" or "---help---" is OK.
It also seems to recommend some indentation under "help", but doesn't
say what that is.  Roman seems to use TAB + "help" and then
TAB SPACE SPACE <help text> under the "help" keyword, but it's not
codified anywhere that I know of.

---
~Randy
