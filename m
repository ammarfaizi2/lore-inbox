Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318661AbSHLDW7>; Sun, 11 Aug 2002 23:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318662AbSHLDW7>; Sun, 11 Aug 2002 23:22:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38552 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318661AbSHLDW6>;
	Sun, 11 Aug 2002 23:22:58 -0400
Date: Sun, 11 Aug 2002 20:13:14 -0700 (PDT)
Message-Id: <20020811.201314.111686100.davem@redhat.com>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1160.1029122409@kao2.melbourne.sgi.com>
References: <20020811.195906.107999483.davem@redhat.com>
	<1160.1029122409@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Mon, 12 Aug 2002 13:20:09 +1000
   
   The problem here is that 'unix' is
 ...
   a symbol that is defined by gcc.

I see.  GCC really shouldn't be doing that as it pollutes the global
namespace.  However, I see current 3.x vintage gcc is still doing it
under Linux so there must be a reason it is kept around.
