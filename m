Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286127AbRLTFkv>; Thu, 20 Dec 2001 00:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286131AbRLTFkm>; Thu, 20 Dec 2001 00:40:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33667 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286128AbRLTFkc>;
	Thu, 20 Dec 2001 00:40:32 -0500
Date: Wed, 19 Dec 2001 21:39:56 -0800 (PST)
Message-Id: <20011219.213956.26276011.davem@redhat.com>
To: riel@conectiva.com.br
Cc: torvalds@transmeta.com, bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
        davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: Scheduler ( was: Just a second ) ...
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33.0112181508001.3410-100000@penguin.transmeta.com>
	<Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Thu, 20 Dec 2001 01:50:36 -0200 (BRST)

   On Tue, 18 Dec 2001, Linus Torvalds wrote:
   
   > The thing is, I'm personally very suspicious of the "features for that
   > exclusive 0.1%" mentality.
   
   Then why do we have sendfile(), or that idiotic sys_readahead() ?

Sending files over sockets are %99 of what most network servers are
actually doing today, it is much more than 0.1% :-)
