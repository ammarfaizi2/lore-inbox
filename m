Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266715AbRHFEdK>; Mon, 6 Aug 2001 00:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266706AbRHFEdA>; Mon, 6 Aug 2001 00:33:00 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:12807 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266715AbRHFEcz>;
	Mon, 6 Aug 2001 00:32:55 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Mirko Lindner <mlindner@syskonnect.de>
Subject: drivers/net/sk98lin/skproc.c undefined root_dev
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 14:33:01 +1000
Message-ID: <346.997072381@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/sk98lin/skproc.c:extern struct net_device *root_dev
Defined extern, all other definitions of root_dev are static, except in
sparc.  CONFIG_SK98LIN is not limited to sparc.  Either the config is
wrong or the code in skproc is wrong.

