Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTLIDHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTLIDHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:07:21 -0500
Received: from mhub-c5.tc.umn.edu ([160.94.128.35]:19852 "EHLO
	mhub-c5.tc.umn.edu") by vger.kernel.org with ESMTP id S262603AbTLIDHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:07:20 -0500
Subject: Re: Kernel include file
From: Matthew Reppert <repp0017@tc.umn.edu>
To: weeteck@linux.net
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20031207161929.7E0953951@sitemail.everyone.net>
References: <20031207161929.7E0953951@sitemail.everyone.net>
Content-Type: text/plain
Message-Id: <1070939237.24409.5.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 21:07:17 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-07 at 10:19, Neo Wee Teck wrote:
> Hmm... wrong idea...
> 
> <new kernel>/include/linux
> 
> update to..
> 
> /usr/include/linux
> 
> Should I?

No.

The headers in /usr/include/linux "belong to" glibc and should never be
changed, as it may cause newly compiled programs to break in nasty and
subtle ways.

kernelnewbies.org has a nice FAQ item on this.

Matt

