Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132429AbRDUCgl>; Fri, 20 Apr 2001 22:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRDUCgb>; Fri, 20 Apr 2001 22:36:31 -0400
Received: from nbecker.fred.net ([216.127.150.111]:42880 "EHLO
	nbecker.fred.net") by vger.kernel.org with ESMTP id <S132429AbRDUCgN>;
	Fri, 20 Apr 2001 22:36:13 -0400
To: linux-kernel@vger.kernel.org
Subject: networked file system
From: nbecker@fred.net
Date: 20 Apr 2001 22:35:29 -0400
Message-ID: <m33db3vv2m.fsf@nbecker.fred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose that an entry on any filesystem could be replaced by a symlink
which pointed to a URL, and that an appropriate handler was dispatched
for that URL.  This would allow, for example, config files to point to
a different machine.

Right now we can accomplish this by mounting alternative file systems
and symlinking to them, but only if an appropriate file system has
been written.
