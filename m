Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbTBUKRR>; Fri, 21 Feb 2003 05:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTBUKRR>; Fri, 21 Feb 2003 05:17:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43983 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267321AbTBUKRQ>;
	Fri, 21 Feb 2003 05:17:16 -0500
Date: Fri, 21 Feb 2003 02:11:25 -0800 (PST)
Message-Id: <20030221.021125.66547838.davem@redhat.com>
To: ak@suse.de
Cc: sim@netnation.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030221102257.GA10108@wotan.suse.de>
References: <20030221072719.GD25144@wotan.suse.de>
	<20030221.014316.69598293.davem@redhat.com>
	<20030221102257.GA10108@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 21 Feb 2003 11:22:58 +0100
   
   Doesn't work on preemptive, does it? How do you keep it on a single CPU
   when it runs in process context ?

What runs in process context?  ICMP responses are generated from BH's.
