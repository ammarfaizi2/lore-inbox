Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318691AbSH1EJL>; Wed, 28 Aug 2002 00:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSH1EJK>; Wed, 28 Aug 2002 00:09:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10645 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318691AbSH1EJK>;
	Wed, 28 Aug 2002 00:09:10 -0400
Date: Tue, 27 Aug 2002 21:07:48 -0700 (PDT)
Message-Id: <20020827.210748.10907440.davem@redhat.com>
To: ldb@ldb.ods.org
Cc: s.biggs@softier.com, linux-kernel@vger.kernel.org
Subject: Re: Bug in kernel code?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1030507839.1547.36.camel@ldb>
References: <1030507070.1489.32.camel@ldb>
	<20020827.205830.72711261.davem@redhat.com>
	<1030507839.1547.36.camel@ldb>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Luca Barbieri <ldb@ldb.ods.org>
   Date: 28 Aug 2002 06:10:39 +0200

   I'm not saying that it's serious bug, just that using __ffs is more
   appropriate than reimplementing it incorrectly and inefficiently.
   
ffs won't find the smallest power of 2 >= some_arbitrary_value.
That is what this code is doing.

I've personally wasted enough typing on this thread, so enough....
