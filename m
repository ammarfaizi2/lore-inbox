Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269950AbTGMPx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 11:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269959AbTGMPx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 11:53:26 -0400
Received: from deepthot.org ([216.19.203.209]:63623 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S269950AbTGMPxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 11:53:24 -0400
From: Jay Denebeim <denebeim@deepthot.org>
X-Newsgroups: dt.kernel
Subject: Could not open debufiles.list on Redhat 9 kernel compile
Date: Sun, 13 Jul 2003 15:45:33 +0000 (UTC)
Organization: Deep Thought
Message-ID: <slrnbh2vlf.ia6.denebeim@hotblack.deepthot.org>
X-Complaints-To: news@deepthot.org
User-Agent: slrn/0.9.7.4 (Linux)
To: linuxkernel@deepthot.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen quite a few references to this with google, I haven't seen a
solution.  The problem is making a stock kernel with 'make rpm' on a
redhat 9 system.  Redhat has done something to rpm with version 9 that
is causing it to create a debug package for every package you make.
Unfortunately whatever it's doing is busted for stock kernels.

I've been unable to find a way to turn off this generation.  There is
a variable %_enable_debug_packages 1 in the redhat macros, I've turned
it off, but that hasn't helped.

So, how do I disable this 'feature'?  Does anyone know?

Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
