Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSJPAmD>; Tue, 15 Oct 2002 20:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264708AbSJPAmC>; Tue, 15 Oct 2002 20:42:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60586 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264690AbSJPAmB>;
	Tue, 15 Oct 2002 20:42:01 -0400
Date: Tue, 15 Oct 2002 17:40:39 -0700 (PDT)
Message-Id: <20021015.174039.27153187.davem@redhat.com>
To: hugh@veritas.com
Cc: akpm@digeo.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fewer unlikely tests
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210152210030.1521-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210152210030.1521-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Tue, 15 Oct 2002 22:11:44 +0100 (BST)

   Occasionally I worry about all those BUG_ON tests we keep adding into
   page_alloc.c.  This patch does one preliminary test of all the flags
   before trying individually.  Maybe you consider this in bad taste,
   or maybe you think it's worthwhile: as you wish.

I definitely like this change.
