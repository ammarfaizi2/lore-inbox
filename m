Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273506AbRIYU2x>; Tue, 25 Sep 2001 16:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273519AbRIYU2n>; Tue, 25 Sep 2001 16:28:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29587 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273506AbRIYU20>;
	Tue, 25 Sep 2001 16:28:26 -0400
Date: Tue, 25 Sep 2001 13:28:16 -0700 (PDT)
Message-Id: <20010925.132816.52117370.davem@redhat.com>
To: riel@conectiva.com.br
Cc: marcelo@conectiva.com.br, andrea@suse.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0109251723160.26091-100000@duckman.distro.conectiva>
In-Reply-To: <20010925.131528.78383994.davem@redhat.com>
	<Pine.LNX.4.33L.0109251723160.26091-100000@duckman.distro.conectiva>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Tue, 25 Sep 2001 17:24:21 -0300 (BRST)
   
   Or were you measuring loads which are mostly read-only ?

When Kanoj Sarcar was back at SGI testing 32 processor Origin
MIPS systems, pagecache_lock was at the top.

Franks a lot,
David S. Miller
davem@redhat.com
