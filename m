Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264780AbSJOR5r>; Tue, 15 Oct 2002 13:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264781AbSJOR5q>; Tue, 15 Oct 2002 13:57:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34470 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264780AbSJOR5q>;
	Tue, 15 Oct 2002 13:57:46 -0400
Date: Tue, 15 Oct 2002 10:56:31 -0700 (PDT)
Message-Id: <20021015.105631.66167488.davem@redhat.com>
To: brak@x.interzone.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 TCP-RST ignored by kernel, keeps sending SYN-ACK (no
 ECN in kernel config)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210151646050.15109-100000@x.interzone.org>
References: <Pine.LNX.4.44.0210151646050.15109-100000@x.interzone.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have to set the ACK bit in your packets, otherwise
the "ACK sequence" lacks any meaning.
