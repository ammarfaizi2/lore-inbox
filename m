Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUCSQED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUCSQED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:04:03 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:63893 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S263027AbUCSQEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:04:01 -0500
Date: Fri, 19 Mar 2004 09:03:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: kgdb-bugreport@lists.sourceforge.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kgdb_arch_set/remove_break() ?
Message-ID: <20040319160359.GD4569@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  Right now I'm writing up a porting doc that describes the various
hook functions we've got.  I noticed that nothing is calling
kgdb_arch_set/remove_break.  Is there some arch we're expecting will
need this?  I'd like to just go ahead and remove them.

-- 
Tom Rini
http://gate.crashing.org/~trini/
