Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284754AbRLKAOZ>; Mon, 10 Dec 2001 19:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284756AbRLKAOP>; Mon, 10 Dec 2001 19:14:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36736 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284754AbRLKAOL>;
	Mon, 10 Dec 2001 19:14:11 -0500
Date: Mon, 10 Dec 2001 16:13:32 -0800 (PST)
Message-Id: <20011210.161332.30184646.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: Mika.Liljeberg@welho.com, linux-kernel@vger.kernel.org
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200112101834.VAA17862@ms2.inr.ac.ru>
In-Reply-To: <3C14FBE7.E3A5F745@welho.com>
	<200112101834.VAA17862@ms2.inr.ac.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Mon, 10 Dec 2001 21:34:47 +0300 (MSK)

   Dave, "official" patch will follow later. I must think about
   some marginal effect in TCP_CLOSE_WAIT and TCP_CLOSING, which can break
   out of switch too. Duh, do specs say something about segments with seqs
   above fin? I do not remember.

A socket in a synchronized state is required to enforce legal sequence
numbers, is it not?
