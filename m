Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbTAMIDW>; Mon, 13 Jan 2003 03:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbTAMIDW>; Mon, 13 Jan 2003 03:03:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22682 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267313AbTAMIDV>;
	Mon, 13 Jan 2003 03:03:21 -0500
Date: Mon, 13 Jan 2003 00:02:40 -0800 (PST)
Message-Id: <20030113.000240.115295412.davem@redhat.com>
To: andersg@0x63.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix locking in /net/ipv4/tcp_ipv4.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030113021150.GB4140@gagarin>
References: <20030113021150.GB4140@gagarin>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anders Gustafsson <andersg@0x63.nu>
   Date: Mon, 13 Jan 2003 03:11:50 +0100

   the goto-discussion* reminded me of the locking for the seq_file reading in
   /net/ipv4/tcp_ipv4.c. If only the header** is read tcp_listen_unlock() is
   called without the lock taken. 
   
Applied, thanks.
