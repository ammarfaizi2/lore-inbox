Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVAPPWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVAPPWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 10:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVAPPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 10:22:32 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:51339 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262526AbVAPPW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 10:22:28 -0500
Date: Sun, 16 Jan 2005 17:22:42 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: changing local version requires full rebuild
Message-ID: <20050116152242.GA4537@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Is it just me, or does changing the local version always require
a full kernel rebuild?

If so, I'd like to fix it, since I like copying
my kernel source with --preserve and changing the
local version, then going back to the old version in case of
a crash.
Its important to change the local version to force 
make install and make modules_install to put things in a separate
directory.

Any ideas on why is that and whether its possible to fix it?

mst
