Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318171AbSGQBLz>; Tue, 16 Jul 2002 21:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318175AbSGQBLy>; Tue, 16 Jul 2002 21:11:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55769 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318171AbSGQBLy>;
	Tue, 16 Jul 2002 21:11:54 -0400
Date: Tue, 16 Jul 2002 18:05:21 -0700 (PDT)
Message-Id: <20020716.180521.57640174.davem@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <ah2frs$164$1@penguin.transmeta.com>
References: <1026869741.2119.112.camel@irongate.swansea.linux.org.uk>
	<20020716.172026.55847426.davem@redhat.com>
	<ah2frs$164$1@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: torvalds@transmeta.com (Linus Torvalds)
   Date: Wed, 17 Jul 2002 01:05:00 +0000 (UTC)

   In article <20020716.172026.55847426.davem@redhat.com>,
   David S. Miller <davem@redhat.com> wrote:
   >Better tell Linus.
   
   Oh, Linus knows.  In fact, Linus wrote some of the code in question. 

Ok, I think the issue here is different.

Several years ago we were returning -EAGAIN from close() via NFS and
that is what caused the problems.
