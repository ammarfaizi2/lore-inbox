Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135813AbREGGcl>; Mon, 7 May 2001 02:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135937AbREGGcc>; Mon, 7 May 2001 02:32:32 -0400
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:19216 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S135813AbREGGcS>;
	Mon, 7 May 2001 02:32:18 -0400
Date: Mon, 7 May 2001 08:26:58 +0200 (CEST)
From: Tobias Ringstrom <tori@tellus.mine.nu>
X-X-Sender: <tori@svea.tellus>
To: "David S. Miller" <davem@redhat.com>
cc: Jonathan Morton <chromi@cyberspace.org>,
        BERECZ Szabolcs <szabi@inf.elte.hu>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: page_launder() bug
In-Reply-To: <15094.10942.592911.70443@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001, David S. Miller wrote:
> It is the most straightforward way to make a '1' or '0'
> integer from the NULL state of a pointer.

But is it really specified in the C "standards" to be exctly zero or one,
and not zero and non-zero?

IMHO, the ?: construct is way more readable and reliable.

/Tobias

