Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbTCLAMm>; Tue, 11 Mar 2003 19:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261730AbTCLAMX>; Tue, 11 Mar 2003 19:12:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47081 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261690AbTCLAKY>;
	Tue, 11 Mar 2003 19:10:24 -0500
Date: Tue, 11 Mar 2003 16:20:53 -0800 (PST)
Message-Id: <20030311.162053.107169287.davem@redhat.com>
To: shemminger@osdl.org
Cc: torvalds@transmeta.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2/8) Eliminate brlock for packet_type
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1047428080.15872.99.camel@dell_ss3.pdx.osdl.net>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
	<1047428080.15872.99.camel@dell_ss3.pdx.osdl.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Hemminger <shemminger@osdl.org>
   Date: 11 Mar 2003 16:14:40 -0800

   Replace linked list for packet_type with brlock with list macros and RCU.
   
Then why is a VLAN patch attached?
