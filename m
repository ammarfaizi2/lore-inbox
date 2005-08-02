Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVHBQEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVHBQEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVHBQCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:02:15 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:9403 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S261489AbVHBQAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:00:23 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: How does umount -a interact with namespaces?
Date: Tue, 2 Aug 2005 11:00:20 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508021100.20131.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way for to get a "global" view of all namespaces (even when 
processes that fork request their own filesystem namespace) that init or 
umount -a can use while shutting down the system?

I don't know how umount -a is suppose to be implemented here...

Rob

