Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUHMXOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUHMXOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUHMXOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:14:49 -0400
Received: from the-village.bc.nu ([81.2.110.252]:55258 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267726AbUHMXON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:14:13 -0400
Subject: Re: binfmt_misc trouble with kernel 2.6.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anand Buddhdev <anand@celtelplus.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411CF503.40202@celtelplus.com>
References: <411CF503.40202@celtelplus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092435114.25002.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 23:11:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 18:06, Anand Buddhdev wrote:
> I created a Fedora bugzilla entry for this but I was told that this is a 
> problem in the kernel upstream. Is this indeed a known problem, and is 
> there a fix?

Its not a kernel problem but a configuration one. The Fedora Core setup
relies on binfmt_misc being a module in order to automount the
binfmt_misc file system. 

