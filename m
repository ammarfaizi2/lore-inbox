Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSLMF2z>; Fri, 13 Dec 2002 00:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSLMF2z>; Fri, 13 Dec 2002 00:28:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21421 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261375AbSLMF2y>;
	Fri, 13 Dec 2002 00:28:54 -0500
Date: Thu, 12 Dec 2002 21:32:31 -0800 (PST)
Message-Id: <20021212.213231.63672402.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH][COMPAT] consolidate sys32_new[lf]stat - architecture
 independent
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
References: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Fri, 13 Dec 2002 15:34:39 +1100

   Another in the COMPAT series.  This build on the previous patches.

I'm totally fine with this stuff (and the sparc64 specific part), but
watch out, this patch removes the kernel/compat.c utimes stuff :-)
