Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263633AbSJHUOI>; Tue, 8 Oct 2002 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263505AbSJHUMx>; Tue, 8 Oct 2002 16:12:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63142 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261441AbSJHUM0>;
	Tue, 8 Oct 2002 16:12:26 -0400
Date: Tue, 08 Oct 2002 13:11:00 -0700 (PDT)
Message-Id: <20021008.131100.47229080.davem@redhat.com>
To: zaitcev@redhat.com
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: kbuild news
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210081442.g98EgeH11258@devserv.devel.redhat.com>
References: <mailman.1034070360.25457.linux-kernel2news@redhat.com>
	<200210081442.g98EgeH11258@devserv.devel.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Tue, 8 Oct 2002 10:42:40 -0400
   
   Let's face it, both btfixup and kallsyms "want" to be the last,
   so something has to give.

No, btfixup does not care about anything that will go into
kallsyms.o, no BTFIXUP objects may appear in kallsyms.

So btfixup may be next to last just fine.
