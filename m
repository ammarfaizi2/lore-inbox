Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbRGKSgs>; Wed, 11 Jul 2001 14:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264965AbRGKSgi>; Wed, 11 Jul 2001 14:36:38 -0400
Received: from h24-65-24-88.gv.shawcable.net ([24.65.24.88]:14249 "HELO
	xabbu.lewp.net") by vger.kernel.org with SMTP id <S264942AbRGKSgX>;
	Wed, 11 Jul 2001 14:36:23 -0400
From: "Izaak Branderhorst" <izaak@lewp.net>
Date: Wed, 11 Jul 2001 12:51:56 -0700
To: linux-kernel@vger.kernel.org
Subject: 2.4.6 - where's inode-max?
Message-ID: <20010711125156.C19104@lewp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently installed 2.4.6 on a large web server and noticed that the kernel
parameter fs.inode-max is nonexistant. I read the sysctl/fs.txt
documentation in the 2.4.6 source tree, which claims it still exists.

I'm a little concerned because fs.inode-state is currently:

141924 0       0       0       0       0       0

According to fs.txt, the second number represents free inodes. Am I
misunderstanding something or is the documentation outdated?

Thanks,
