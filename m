Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTEOUCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTEOUBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:01:21 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:27536 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264227AbTEOUBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:01:05 -0400
Date: Thu, 15 May 2003 14:13:53 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Looking for some BK assistance
Message-ID: <267360000.1053029633@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to merge my 2.4.X BK tree with Marcelo's tree.  In the end,
I want to have a tree that I can "bk send" to Marcelo that backs out
the recent backout of the aic7xxx driver and puts the aic79xx driver
back into its original location.  I understand how to override incoming
content changes during the merge process, but the documentation on
undoing renames is a bit vague.  During the merge process, my local
file name is already a deleted name that is slightly different than
the name in the parent repository.  If I try to resolve the rename by
putting the file back into its original location, BK complains that that
name already exists.  The documentation also warns that renames should
only be performed in the master repository.  Can someone with BK clue
point me in the right direction on this one?

Thanks,
Justin

