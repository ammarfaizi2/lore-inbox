Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTIVDHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 23:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbTIVDH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 23:07:29 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:35068 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262758AbTIVDH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 23:07:29 -0400
Subject: CLONE_SIGHAND w/o CLONE_VM
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1064199244.746.401.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Sep 2003 22:54:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does CLONE_SIGHAND without CLONE_VM ever
make sense?

Note that the arch-specific kernel_thread()
implementations add CLONE_VM, so kernel_thread()
usage doesn't count unless you can point to an
arch that doesn't add the CLONE_VM flag. (BTW, the
user-mode port is missing CLONE_UNTRACED. Bug?)


