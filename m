Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbSJCOw2>; Thu, 3 Oct 2002 10:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbSJCOw1>; Thu, 3 Oct 2002 10:52:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63954 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261571AbSJCOw0>;
	Thu, 3 Oct 2002 10:52:26 -0400
Date: Thu, 03 Oct 2002 07:50:34 -0700 (PDT)
Message-Id: <20021003.075034.12648168.davem@redhat.com>
To: manfred@colorfullife.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.40-ac1
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D9C5827.70703@colorfullife.com>
References: <3D9C5827.70703@colorfullife.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Manfred Spraul <manfred@colorfullife.com>
   Date: Thu, 03 Oct 2002 16:45:59 +0200

   On big endian computers, the nic is set into a big-endian mode, and it 
   did work with set_bit on my power mac. Unfortunately, I don't have 
   access to it right now.
   
How about a 64-bit system where set_bit works on 64-bit longs
and not 32-bit ones?  That is why the current code there is broken.
