Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSFLV7X>; Wed, 12 Jun 2002 17:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317336AbSFLV7W>; Wed, 12 Jun 2002 17:59:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18645 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317334AbSFLV7V>;
	Wed, 12 Jun 2002 17:59:21 -0400
Date: Wed, 12 Jun 2002 14:54:53 -0700 (PDT)
Message-Id: <20020612.145453.95533845.davem@redhat.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, kravetz@us.ibm.com, rml@tech9.net,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] switch_mm()'s desire to run without the rq lock
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0206121551190.10732-100000@elte.hu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Wed, 12 Jun 2002 18:57:34 +0200 (CEST)

   here is a solution that allows us to eat and have the pudding at once.  
   (patch attached, against Linus' latest BK tree):
   
Thanks for doing this, it looks fine to me.  Also, thanks for being so
thorough in your testing.  If only everyone would do this :-)
