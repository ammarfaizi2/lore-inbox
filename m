Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWAFBND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWAFBND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWAFBND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:13:03 -0500
Received: from quechua.inka.de ([193.197.184.2]:20650 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932367AbWAFBNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:13:01 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060106001943.GE5516@filer.fsl.cs.sunysb.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EugA7-00075r-00@calista.inka.de>
Date: Fri, 06 Jan 2006 02:12:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> That's something to watch out for...If you say have:
> 
> printk(KERN_DEBUG "fooo.....");
> do_foo();
> printk(KERN_DEBUG "done.\n");

dont do it. It is better to have the time stamps for both and to have atomic
prints. In fact I would disallow this and add automatic linebreaks.

Gruss
Bernd
