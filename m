Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262743AbSJLCl4>; Fri, 11 Oct 2002 22:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSJLClz>; Fri, 11 Oct 2002 22:41:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63872 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262743AbSJLClz>;
	Fri, 11 Oct 2002 22:41:55 -0400
Date: Fri, 11 Oct 2002 19:41:08 -0700 (PDT)
Message-Id: <20021011.194108.102576152.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: mk@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] USAGI IPsec
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021012.114330.78212112.yoshfuji@linux-ipv6.org>
References: <m3u1js1l1a.wl@karaba.org>
	<20021011.185332.115906289.davem@redhat.com>
	<20021012.114330.78212112.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Sat, 12 Oct 2002 11:43:30 +0900 (JST)
   
   Would you tell us the points of the "several details," please?

We believe that the whole SPD/SAD mechanism should move
eventually to a top-level flow cache shared by ipv4 and
ipv6.

Therefore all the interfaces will be architected such that
a move to a flow cache based lookup system will be a very
simple change.
