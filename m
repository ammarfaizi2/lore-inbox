Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274749AbRJNHrm>; Sun, 14 Oct 2001 03:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274666AbRJNHrW>; Sun, 14 Oct 2001 03:47:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47243 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274746AbRJNHrP>;
	Sun, 14 Oct 2001 03:47:15 -0400
Date: Sun, 14 Oct 2001 00:47:44 -0700 (PDT)
Message-Id: <20011014.004744.51856957.davem@redhat.com>
To: Mika.Liljeberg@welho.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC9393D.765A156@welho.com>
In-Reply-To: <3BC8DAF0.3D16A546@welho.com>
	<20011013.234016.104032175.davem@redhat.com>
	<3BC9393D.765A156@welho.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mika Liljeberg <Mika.Liljeberg@welho.com>
   Date: Sun, 14 Oct 2001 10:05:33 +0300
   
   I've attached a fragment of tcpdump output from the middle of steady
   state transfer. Looking at the dump, it seems that most arriving
   segments have the PSH bit set. This leads me to believe that the
   transfer is mostly application limited at the sender side.

This means the application is doing many small writes.  To be honest,
to only sure way to cure any performance problems from that is to
fix the application in question.  What is this application?

Franks a lot,
David S. Miller
davem@redhat.com
