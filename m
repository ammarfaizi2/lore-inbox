Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbSIZVcj>; Thu, 26 Sep 2002 17:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSIZVci>; Thu, 26 Sep 2002 17:32:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50314 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261535AbSIZVch>;
	Thu, 26 Sep 2002 17:32:37 -0400
Date: Thu, 26 Sep 2002 14:31:31 -0700 (PDT)
Message-Id: <20020926.143131.52117281.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Don't Process ND Messages with Invalid Options
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020925.133031.538200492.yoshfuji@linux-ipv6.org>
References: <20020925.133031.538200492.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Wed, 25 Sep 2002 13:30:31 +0900 (JST)

   Linux happened to process invalid ND messages with invalid options
   such as
    - length of ND options is 0
    - length of ND options is not enough
   Specification says that such messages must be silently discarded.
   This patch parses/checks ND options before it changes state of
   neighbour / address etc. and ignores such messages.
   
   Following patch is against linux-2.4.19.

Patch applied to 2.4.x and 2.5.x, thanks a lot.

Let us hope more patches like this one are coming :-)
