Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135997AbREGE4h>; Mon, 7 May 2001 00:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135998AbREGE41>; Mon, 7 May 2001 00:56:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4515 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135997AbREGE4T>;
	Mon, 7 May 2001 00:56:19 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15094.10942.592911.70443@pizda.ninka.net>
Date: Sun, 6 May 2001 21:55:26 -0700 (PDT)
To: Jonathan Morton <chromi@cyberspace.org>
Cc: BERECZ Szabolcs <szabi@inf.elte.hu>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: page_launder() bug
In-Reply-To: <l03130303b71b795cab9b@[192.168.239.105]>
In-Reply-To: <Pine.A41.4.31.0105062307290.59664-100000@pandora.inf.elte.hu>
	<l03130303b71b795cab9b@[192.168.239.105]>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Morton writes:
 > >-			 page_count(page) == (1 + !!page->buffers));
 > 
 > Two inversions in a row?

It is the most straightforward way to make a '1' or '0'
integer from the NULL state of a pointer.

Later,
David S. Miller
davem@redhat.com
