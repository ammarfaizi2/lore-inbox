Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTAPAPM>; Wed, 15 Jan 2003 19:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbTAPAPM>; Wed, 15 Jan 2003 19:15:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57519 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266938AbTAPAO3>;
	Wed, 15 Jan 2003 19:14:29 -0500
Date: Wed, 15 Jan 2003 16:13:37 -0800 (PST)
Message-Id: <20030115.161337.14085475.davem@redhat.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix up RTM_SETLINK handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52of6ihrk1.fsf@topspin.com>
References: <52smvukic3.fsf@topspin.com>
	<20030115.160716.23576593.davem@redhat.com>
	<52of6ihrk1.fsf@topspin.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 15 Jan 2003 16:22:22 -0800
   
   If you prefer, I could add a call_netdevice_notifiers() to dev.c and
   leave netdev_chain static.  Just let me know and I'll make a new
   patch.
   
Yes, that is the preferred way to do this.
