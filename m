Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTBDHn2>; Tue, 4 Feb 2003 02:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbTBDHn1>; Tue, 4 Feb 2003 02:43:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63686 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267145AbTBDHn1>;
	Tue, 4 Feb 2003 02:43:27 -0500
Date: Mon, 03 Feb 2003 23:39:48 -0800 (PST)
Message-Id: <20030203.233948.53493107.davem@redhat.com>
To: greearb@candelatech.com
Cc: john@grabjohn.com, cfriesen@nortelnetworks.com, ahu@ds9a.nl,
       linux-kernel@vger.kernel.org
Subject: Re: problems achieving decent throughput with latency.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E3F70AD.7060901@candelatech.com>
References: <3E3EAF04.9010308@candelatech.com>
	<20030203.211933.27826107.davem@redhat.com>
	<3E3F70AD.7060901@candelatech.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Mon, 03 Feb 2003 23:50:05 -0800
   
   Why would it use the maximum socket for a connection with low to
   no acks, ie low to no throughput?

You open up the congestion window by ACK'ing a few windows
worth of data, then you stop ACK'ing.

I'm sorry if that wasn't obvious.
