Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313564AbSDZAqz>; Thu, 25 Apr 2002 20:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313592AbSDZAqy>; Thu, 25 Apr 2002 20:46:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5525 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313564AbSDZAqx>;
	Thu, 25 Apr 2002 20:46:53 -0400
Date: Thu, 25 Apr 2002 17:37:05 -0700 (PDT)
Message-Id: <20020425.173705.111688082.davem@redhat.com>
To: pavel@ucw.cz
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: Warn about trap for programmer in mm.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020425100440.GA5061@elf.ucw.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@ucw.cz>
   Date: Thu, 25 Apr 2002 12:04:40 +0200
   
   As suggested by A.Morton:
 ...   									Pavel

    #define PG_launder		15	/* written out by VM pressure.. */
   -
    #define PG_private		16	/* Has something at ->private */
   +/* Top 8 bits are used for page's zone in 2.4-ac and 2.5, don't use them */

What does top 8 bites mean on a type whose size
is dependent upon the architecture? :-)
