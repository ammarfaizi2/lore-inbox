Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSKKXdY>; Mon, 11 Nov 2002 18:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbSKKXdY>; Mon, 11 Nov 2002 18:33:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8633 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265909AbSKKXdX>;
	Mon, 11 Nov 2002 18:33:23 -0500
Date: Mon, 11 Nov 2002 15:38:45 -0800 (PST)
Message-Id: <20021111.153845.69968013.davem@redhat.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52r8drn0jk.fsf_-_@topspin.com>
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
	<20021111.151929.31543489.davem@redhat.com>
	<52r8drn0jk.fsf_-_@topspin.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So how are apps able to specify such larger hw addresses to configure
a driver if IFHWADDRLEN is still 6?

I'm not going to increase MAX_ADDR_LEN if there is no user ABI capable
of configuring such larger addresses properly.
