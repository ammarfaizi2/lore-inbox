Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbSJ1NE7>; Mon, 28 Oct 2002 08:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262454AbSJ1NE7>; Mon, 28 Oct 2002 08:04:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18858 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262453AbSJ1NE7>;
	Mon, 28 Oct 2002 08:04:59 -0500
Date: Mon, 28 Oct 2002 05:02:07 -0800 (PST)
Message-Id: <20021028.050207.05282480.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: linux-kernel@vger.kernel.org, buytenh@gnu.org, coreteam@netfilter.org
Subject: Re: [PATCH][RFC] bridge-nf -- map IPv4 hooks onto bridge hooks -
 try 3, vs 2.5.44
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210250801.16278.bart.de.schuymer@pandora.be>
References: <200210210020.37097.bart.de.schuymer@pandora.be>
	<200210230140.27470.bart.de.schuymer@pandora.be>
	<200210250801.16278.bart.de.schuymer@pandora.be>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Fri, 25 Oct 2002 08:01:16 +0200

   The following patch deals with the problems you still had with the earlier one.
   Changes:
   1. add #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE) everywhere
   2. don't touch ip_tables.c
   3. no ipt_physdev.c file yet. I'll try to make it this weekend.
   
I've applied this to my tree, thanks.
