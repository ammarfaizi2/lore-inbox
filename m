Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268471AbTCCJD0>; Mon, 3 Mar 2003 04:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268478AbTCCJDZ>; Mon, 3 Mar 2003 04:03:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35239 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268471AbTCCJDY>;
	Mon, 3 Mar 2003 04:03:24 -0500
Date: Mon, 03 Mar 2003 00:56:10 -0800 (PST)
Message-Id: <20030303.005610.89909867.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] get minimum frame size right in lec.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200302241346.h1ODkuue028665@locutus.cmf.nrl.navy.mil>
References: <200302241346.h1ODkuue028665@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Mon, 24 Feb 2003 08:46:56 -0500

   the minimum frame size for token ring (802.5) pdus is 16 octets.  also,
   count the pdus that failed to copy as dropped.  also, skb_copy_expand()
   now seems to be the right way to do this.
   
Applied, thanks.
