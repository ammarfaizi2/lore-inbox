Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293550AbSCKCeR>; Sun, 10 Mar 2002 21:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293557AbSCKCeH>; Sun, 10 Mar 2002 21:34:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:442 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293550AbSCKCdq>;
	Sun, 10 Mar 2002 21:33:46 -0500
Date: Sun, 10 Mar 2002 18:30:33 -0800 (PST)
Message-Id: <20020310.183033.67792009.davem@redhat.com>
To: bcrl@redhat.com
Cc: whitney@math.berkeley.edu, rgooch@ras.ucalgary.ca,
        linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020310212210.A27870@redhat.com>
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
	<20020310.180456.91344522.davem@redhat.com>
	<20020310212210.A27870@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Sun, 10 Mar 2002 21:22:10 -0500
   
   That's my fault.  The version of the driver in the kernel atm sucks in 
   performance; I'll try to spend the day needed on the driver this week 
   and it should get up to ~800mbit from the current mess.  Getting NAPI 
   in the kernel would help... ;-)

Syskonnect sk98 with jumbo frames gets ~107MB/sec TCP bandwidth
without NAPI, there is no reason other cards cannot go full speed as
well.

NAPI is really only going to help with high packet rates not with
thinks like raw bandwidth tests.
