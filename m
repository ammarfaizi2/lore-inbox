Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268676AbTCCRCj>; Mon, 3 Mar 2003 12:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268617AbTCCRCi>; Mon, 3 Mar 2003 12:02:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4779 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268620AbTCCRCe>;
	Mon, 3 Mar 2003 12:02:34 -0500
Date: Mon, 03 Mar 2003 08:55:04 -0800 (PST)
Message-Id: <20030303.085504.105424448.davem@redhat.com>
To: cfriesen@nortelnetworks.com
Cc: terje.eggestad@scali.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: anyone ever done multicast AF_UNIX sockets?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E638C51.2000904@nortelnetworks.com>
References: <3E5E7081.6020704@nortelnetworks.com>
	<1046695876.7731.78.camel@pc-16.office.scali.no>
	<3E638C51.2000904@nortelnetworks.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Friesen <cfriesen@nortelnetworks.com>
   Date: Mon, 03 Mar 2003 12:09:37 -0500

   Unless you poll for messages on the receiving side, how do you trigger 
   the receiver to look for a message?

Send signals.  Use a FUTEX, be creative...

