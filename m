Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264755AbTFAWsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbTFAWsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:48:39 -0400
Received: from dp.samba.org ([66.70.73.150]:5087 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264755AbTFAWsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:48:38 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16090.34236.144618.434700@argo.ozlabs.ibm.com>
Date: Mon, 2 Jun 2003 09:01:16 +1000
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
In-Reply-To: <1054479734.19552.51.camel@spc>
References: <1054446976.19557.23.camel@spc>
	<20030601132626.GA3012@work.bitmover.com>
	<20030601134942.GA10750@alpha.home.local>
	<20030601140602.GA3641@work.bitmover.com>
	<1054479734.19552.51.camel@spc>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole writes:

> Here is a snippet of a patch from arch/ppc/xmon/ppc-opc.c:

Given that that file is a direct lift from binutils, I would rather
update it with the latest version from binutils than waste time on
reformatting, if it really bothers you.

My opinion is that changing code that works and that doesn't need
attention is a waste of time.  If you're working on some code (or even
if you are just trying to understand it and you want to make it clearer),
then fine, reformat/re-indent/fix argument declarations/whatever, but
if you're not, find something more productive to do.

Paul.
