Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRLQPAV>; Mon, 17 Dec 2001 10:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280012AbRLQPAM>; Mon, 17 Dec 2001 10:00:12 -0500
Received: from [139.85.108.65] ([139.85.108.65]:40148 "EHLO rpppc1.hns.com")
	by vger.kernel.org with ESMTP id <S279307AbRLQPAB>;
	Mon, 17 Dec 2001 10:00:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Why no -march=athlon?
From: nbecker@fred.net
Date: 17 Dec 2001 09:59:56 -0500
Message-ID: <x88r8ptki37.fsf@rpppc1.hns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that linux/arch/i386/Makefile says:

ifdef CONFIG_MK7
CFLAGS += -march=i686 -malign-functions=4 
endif


Why not -march=athlon?  Is this just for compatibility with old gcc?
If so, can't we fix it with an ifdef?
