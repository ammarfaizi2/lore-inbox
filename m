Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbSJCNej>; Thu, 3 Oct 2002 09:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263271AbSJCNej>; Thu, 3 Oct 2002 09:34:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14034 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261278AbSJCNei>;
	Thu, 3 Oct 2002 09:34:38 -0400
Date: Thu, 03 Oct 2002 06:32:56 -0700 (PDT)
Message-Id: <20021003.063256.84377325.davem@redhat.com>
To: linux_4ever@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40 - remove IPV6_ADDRFORM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021003133634.9670.qmail@web9605.mail.yahoo.com>
References: <20021003.054332.22032944.davem@redhat.com>
	<20021003133634.9670.qmail@web9605.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steve G <linux_4ever@yahoo.com>
   Date: Thu, 3 Oct 2002 06:36:34 -0700 (PDT)

   >Also, if you are going to fix the indentation in 
   >the header file, please do so in a seperate patch.
   
   Hmmm, I only wanted to renumber the options since #1
   was removed. Sorry if it changed the alignment.

Don't do that, then every one of those ipv6 options you change which
are being used by userspace breaks.  What made you think such a change
would be legal?
