Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSCAPgD>; Fri, 1 Mar 2002 10:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293213AbSCAPfy>; Fri, 1 Mar 2002 10:35:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4486 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293203AbSCAPfi>;
	Fri, 1 Mar 2002 10:35:38 -0500
Date: Fri, 01 Mar 2002 07:33:28 -0800 (PST)
Message-Id: <20020301.073328.124865821.davem@redhat.com>
To: dwmw2@infradead.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ? 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <22820.1014996781@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0202280854250.15607-100000@home.transmeta.com>
	<22820.1014996781@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Woodhouse <dwmw2@infradead.org>
   Date: Fri, 01 Mar 2002 15:33:01 +0000

   
   torvalds@transmeta.com said:
   >    compat-2.4.h:
   > 	#define recalc_sigpending() recalc_sigpending(current)
   
   > so what are you complaining about? 
   
   It may be possible, but it's not a trivial one-liner.

Add a space to the definition, ala "recalc_sigpending (current)"
so that CPP expands the module version properly.
