Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSEXVep>; Fri, 24 May 2002 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSEXVeo>; Fri, 24 May 2002 17:34:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9859 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311752AbSEXVen>;
	Fri, 24 May 2002 17:34:43 -0400
Date: Fri, 24 May 2002 14:20:09 -0700 (PDT)
Message-Id: <20020524.142009.51764018.davem@redhat.com>
To: spy9599@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Few comments on TCP implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020524213011.50807.qmail@web14808.mail.yahoo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Yogesh Swami <spy9599@yahoo.com>
   Date: Fri, 24 May 2002 14:30:11 -0700 (PDT)
   
   c) There are numerous heuristics at work with no  RFC
   counterparts (rate halving etc etc). To have the best
   performance its probably best to stick with RFCs, or
   if there is a compelling need to have these heuristics
   then they should be brought to the IETF first.
   Implementing something based on someone's random
   publications is not a good idea for an operating as
   pervasive as Linux.

Wrong.  Half of the RFCs have flaws, and if we just would "stick to
RFCs" we'd have a lot of problems.  Most of things Linux does
different are just fixes for these errors in the RFCs.
