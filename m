Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281192AbRKLXXj>; Mon, 12 Nov 2001 18:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281191AbRKLXXc>; Mon, 12 Nov 2001 18:23:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62085 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281189AbRKLXXY>;
	Mon, 12 Nov 2001 18:23:24 -0500
Date: Mon, 12 Nov 2001 15:23:04 -0800 (PST)
Message-Id: <20011112.152304.39155908.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: helgehaf@idb.hist.no, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011112205905.4a695ed3.rusty@rustcorp.com.au>
In-Reply-To: <20011109141215.08d33c96.rusty@rustcorp.com.au>
	<3BEBBB21.357149FC@idb.hist.no>
	<20011112205905.4a695ed3.rusty@rustcorp.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 12 Nov 2001 20:59:05 +1100

   (atomic_inc & atomic_dec_and_test for every packet, anyone?).

We already do pay that price, in skb_release_data() :-)
