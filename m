Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbTAPBYv>; Wed, 15 Jan 2003 20:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbTAPBYv>; Wed, 15 Jan 2003 20:24:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17072 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266957AbTAPBYu>;
	Wed, 15 Jan 2003 20:24:50 -0500
Date: Wed, 15 Jan 2003 17:23:58 -0800 (PST)
Message-Id: <20030115.172358.66314347.davem@redhat.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix up RTM_SETLINK handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52adi1999k.fsf@topspin.com>
References: <52of6ihrk1.fsf@topspin.com>
	<20030115.161337.14085475.davem@redhat.com>
	<52adi1999k.fsf@topspin.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 15 Jan 2003 17:24:39 -0800

   I added a function call_netdevice_notifiers() instead of making
   netdev_chain not static.

Missing module symbol export.
