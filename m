Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSFQVif>; Mon, 17 Jun 2002 17:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSFQVie>; Mon, 17 Jun 2002 17:38:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45978 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317035AbSFQVid>;
	Mon, 17 Jun 2002 17:38:33 -0400
Date: Mon, 17 Jun 2002 14:33:19 -0700 (PDT)
Message-Id: <20020617.143319.54623892.davem@redhat.com>
To: critson@perlfu.co.uk
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH][2.5.22] OOPS in tcp_v6_get_port
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0206171314460.2496-300000@lain.perlfu.co.uk>
References: <Pine.LNX.4.44.0206171314460.2496-300000@lain.perlfu.co.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a known bug introduced by the struct sock splitup into
external per-protocol pieces done by Arnaldo de Melo.  He is working
on the proper fix, your proposed change will just paper over the real
bug.
