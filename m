Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSJQBaB>; Wed, 16 Oct 2002 21:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSJQBaB>; Wed, 16 Oct 2002 21:30:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1719 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261616AbSJQBaA>;
	Wed, 16 Oct 2002 21:30:00 -0400
Date: Wed, 16 Oct 2002 18:28:14 -0700 (PDT)
Message-Id: <20021016.182814.23034875.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: make arp seq_file show method only produce one
 record per call
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15790.4803.492885.687276@notabene.cse.unsw.edu.au>
References: <20021017011108.GT7541@conectiva.com.br>
	<20021016.181550.88499112.davem@redhat.com>
	<15790.4803.492885.687276@notabene.cse.unsw.edu.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Thu, 17 Oct 2002 11:30:43 +1000
   
   I use seq->private for private state for /proc/fs/nfs/exports.
   It works nicely.
   You need to define an 'open' the sets it up, and a 'release' to
   tear it down, rather than doing it in start/stop.
   See fs/nfsd/fnsctl.c:exports_open

Hmmm, Arnaldo? :-)
