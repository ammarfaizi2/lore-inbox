Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318151AbSIJV34>; Tue, 10 Sep 2002 17:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSIJV34>; Tue, 10 Sep 2002 17:29:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22188 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318151AbSIJV3z>;
	Tue, 10 Sep 2002 17:29:55 -0400
Date: Tue, 10 Sep 2002 14:26:46 -0700 (PDT)
Message-Id: <20020910.142646.97775138.davem@redhat.com>
To: steve@neptune.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209101732350.17602-100000@triton.neptune.on.ca>
References: <20020910.142108.08824481.davem@redhat.com>
	<Pine.LNX.4.44.0209101732350.17602-100000@triton.neptune.on.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steve Mickeler <steve@neptune.ca>
   Date: Tue, 10 Sep 2002 17:33:15 -0400 (EDT)
   
   Yes, all I patched was tg3.c and tg3.h

That isn't going to work, the current driver uses NAPI
which means you need the rest of the 2.4.20-X networking
bits too.
