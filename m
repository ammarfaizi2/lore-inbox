Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261918AbSI3EaA>; Mon, 30 Sep 2002 00:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbSI3E37>; Mon, 30 Sep 2002 00:29:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2477 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261918AbSI3E37>;
	Mon, 30 Sep 2002 00:29:59 -0400
Date: Sun, 29 Sep 2002 21:28:31 -0700 (PDT)
Message-Id: <20020929.212831.103134018.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       wli@holomorphy.com, kuznet@ms2.inr.ac.ru
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020930100317.A21939@in.ibm.com>
References: <20020930004559.A19071@in.ibm.com>
	<20020929.172022.23984844.davem@redhat.com>
	<20020930100317.A21939@in.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Mon, 30 Sep 2002 10:03:17 +0530

   This is the list, I think,  by looking at packet_types -

You look at old sources then, in current 2.5.x psnap.c and ext8022.c
are taken care of by Arnaldo's LLC stack.  He is hacking x25 as well.
Ralf Baechle is doing ax25/rose/etc. radio layers.  Appletalk should
be sane in 2.5.x as well.
