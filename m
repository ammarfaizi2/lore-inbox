Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUE1Thk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUE1Thk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUE1Thk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:37:40 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:4229 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S263823AbUE1Thj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:37:39 -0400
From: Rob Landley <rob@landley.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: swappiness=0 makes software suspend fail.
Date: Fri, 28 May 2004 00:00:56 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405280000.56742.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With swappiness at the default (60), software suspend frees all the memory it 
needs.  With swappiness at 0, software suspend basically doesn't free any 
memory, and the suspend gets aborted.

Just thought I'd mention it.  Tried on 2.6.6...

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

