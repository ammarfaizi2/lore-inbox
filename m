Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293452AbSBZBwN>; Mon, 25 Feb 2002 20:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSBZBwE>; Mon, 25 Feb 2002 20:52:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30627 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293447AbSBZBvr>;
	Mon, 25 Feb 2002 20:51:47 -0500
Date: Mon, 25 Feb 2002 17:49:11 -0800 (PST)
Message-Id: <20020225.174911.82037594.davem@redhat.com>
To: riel@conectiva.com.br
Cc: marcelo@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct page shrinkage
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0202252245460.7820-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202252245460.7820-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Mon, 25 Feb 2002 22:47:00 -0300 (BRT)

   Please apply for 2.4.19-pre2.

Please fix the atomic_t assumptions in init_page_count() first.
You should be using atomic_set(...).

Franks a lot,
David S. Miller
davem@redhat.com
