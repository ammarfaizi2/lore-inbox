Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSH1BIy>; Tue, 27 Aug 2002 21:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318432AbSH1BIx>; Tue, 27 Aug 2002 21:08:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47507 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318389AbSH1BIv>;
	Tue, 27 Aug 2002 21:08:51 -0400
Date: Tue, 27 Aug 2002 18:07:35 -0700 (PDT)
Message-Id: <20020827.180735.00300710.davem@redhat.com>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbd_bh() is entered during kbd_init()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020828004040.GA2516@holomorphy.com>
References: <20020828004040.GA2516@holomorphy.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Tue, 27 Aug 2002 17:40:40 -0700
   
   kbd_init() needs to disable interrupts.

That won't cure the problem on SMP.
