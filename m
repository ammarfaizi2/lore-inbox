Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271071AbTHCHxB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbTHCHxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:53:01 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:1551 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S271071AbTHCHxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:53:00 -0400
To: linux-kernel@vger.kernel.org
Subject: Polling large file descriptor sets
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 03 Aug 2003 09:52:58 +0200
Message-ID: <87y8ybw52d.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that /dev/epoll support will be included in 2.6.  Is this the
official way to solve the problem, or is there another, preferred
interface I have missed?  Is the current /dev/epoll edge-triggered or
level-triggered?

Is the patch for 2.4.21 in sync with 2.6, API-wise?  Can I run
libevent with both kernels?
