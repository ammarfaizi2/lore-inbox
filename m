Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313358AbSDYQZJ>; Thu, 25 Apr 2002 12:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313403AbSDYQZI>; Thu, 25 Apr 2002 12:25:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3979 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313358AbSDYQZH>;
	Thu, 25 Apr 2002 12:25:07 -0400
To: linux-kernel@vger.kernel.org
Subject: Faster logging?
From: nbecker@hns.com (Neal D. Becker)
Date: 25 Apr 2002 11:50:36 -0400
Message-ID: <x88662frd4j.fsf@rpppc1.md.hns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to debug using printk, we are getting buffer overun.  I think
that setting klogd to flush faster would fix this.  Man klogd doesn't
show any option to control the time that klogd sleeps.  Seems to me
that's a simple option to add.
