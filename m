Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270050AbRIEBvj>; Tue, 4 Sep 2001 21:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270073AbRIEBva>; Tue, 4 Sep 2001 21:51:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14214 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270050AbRIEBvM>;
	Tue, 4 Sep 2001 21:51:12 -0400
Date: Tue, 04 Sep 2001 18:51:23 -0700 (PDT)
Message-Id: <20010904.185123.26276785.davem@redhat.com>
To: andrew.grover@intel.com
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, _deepfire@mail.ru
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0E2@orsmsx35.jf.intel.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0E2@orsmsx35.jf.intel.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Grover, Andrew" <andrew.grover@intel.com>
   Date: Tue, 4 Sep 2001 14:52:17 -0700 
   
   I'm not advocating anything similar for Linux, I'm just saying it's an
   interesting thought experiment - what if the SMP-ness of a machine was
   abstracted from the kernel proper? How much of the kernel really cares, or
   really *should* care about SMP/UP?

Every spinlock :-) You'd have to either accept their overhead, or have
some way to nop out the instructions on uniprocessor boots.  There
would still be the space overhead after such code patching.

I remember the Digital UNIX folks did something interesting in this
area.  There should be a paper online somewhere.

Later,
David S. Miller
davem@redhat.com

