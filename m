Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbSIYH4R>; Wed, 25 Sep 2002 03:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261937AbSIYH4R>; Wed, 25 Sep 2002 03:56:17 -0400
Received: from closet.leakybucket.net ([208.177.155.94]:24704 "HELO
	closet.leakybucket.org") by vger.kernel.org with SMTP
	id <S261334AbSIYH4Q>; Wed, 25 Sep 2002 03:56:16 -0400
Date: Tue, 24 Sep 2002 17:33:53 -0700
From: alfred@leakybucket.org
To: linux-kernel@vger.kernel.org
Subject: 2 futex questions
Message-ID: <20020925003353.GA15418@closet.leakybucket.org>
Reply-To: alfred@leakybucket.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) There's a comment in sys_futex(...) that says pos_in_page must not be on a page boundary.
Could someone explain why?

2) How is this ever true:
	pos_in_page + sizeof(int) > PAGE_SIZE
when checking if pos_in_page is valid?


Thanks,
Alfred Landrum
