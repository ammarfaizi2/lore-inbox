Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSFREWf>; Tue, 18 Jun 2002 00:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSFREWe>; Tue, 18 Jun 2002 00:22:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12190 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317308AbSFREWe>;
	Tue, 18 Jun 2002 00:22:34 -0400
Date: Mon, 17 Jun 2002 21:17:21 -0700 (PDT)
Message-Id: <20020617.211721.123286561.davem@redhat.com>
To: acme@conectiva.com.br
Cc: critson@perlfu.co.uk, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [BKPATCH] Re: [PATCH][2.5.22] OOPS in tcp_v6_get_port
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020618041539.GB18759@conectiva.com.br>
References: <20020618024934.GA4274@conectiva.com.br>
	<20020618035804.GA18759@conectiva.com.br>
	<20020618041539.GB18759@conectiva.com.br>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Tue, 18 Jun 2002 01:15:39 -0300
   
   Oops, brain fart, David, please don't apply, in tcp_create_openreq_child
   we overwrite the ->pinet6 field after the constructor inits it to the proper
   value :( Please leave the old patch in place for a while... :(

No problem.
