Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbSJQBRQ>; Wed, 16 Oct 2002 21:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSJQBRQ>; Wed, 16 Oct 2002 21:17:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61878 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261606AbSJQBRP>;
	Wed, 16 Oct 2002 21:17:15 -0400
Date: Wed, 16 Oct 2002 18:15:50 -0700 (PDT)
Message-Id: <20021016.181550.88499112.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: make arp seq_file show method only produce one
 record per call
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017011108.GT7541@conectiva.com.br>
References: <20021017010135.GR7541@conectiva.com.br>
	<20021016.175809.28811497.davem@redhat.com>
	<20021017011108.GT7541@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Wed, 16 Oct 2002 22:11:08 -0300

   That would be nice, yes, bastardizing pos for this is, humm, ugly, and
   it isn't accessible at show time (pun intended 8) ).

Can you remind me what the original objection was to
just using seq->private?  Is it used, or planned to
be used, by something else?
