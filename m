Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbUCNOck (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 09:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUCNOck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 09:32:40 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:35411 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262456AbUCNOcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 09:32:12 -0500
Subject: amd64-agp problems partly solved...
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079274730.5546.2.camel@redeeman.linux.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Mar 2004 15:32:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have now found a way to "fix" the problem, but it surely isnt the way
it should be.

if you first start xfree without amd64-agp module loaded, so X starts
without agp, and then stop xfree, and modprobe amd64-agp and start
xfree, it works... very strange, this is probably a fault by nvidia,
becaues their drivers doesent initialize agp proper, but there is a
chance that its a kernel bug too, i dont know, if you know, please let
me know


-- 
Redeeman <lkml@metanurb.dk>

