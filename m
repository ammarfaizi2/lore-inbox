Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSEXVJ2>; Fri, 24 May 2002 17:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSEXVJ1>; Fri, 24 May 2002 17:09:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58498 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310835AbSEXVJZ>;
	Fri, 24 May 2002 17:09:25 -0400
Date: Fri, 24 May 2002 13:54:53 -0700 (PDT)
Message-Id: <20020524.135453.115381323.davem@redhat.com>
To: cfriesen@nortelnetworks.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get per-socket stats on udp rx buffer overflow?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CEEA9BA.AAFED19F@nortelnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Friesen <cfriesen@nortelnetworks.com>
   Date: Fri, 24 May 2002 16:59:38 -0400

   Is there any way for me to see how many incoming packets were dropped on a udp
   socket due to overflowing the input buffer?  I specifically want this
   information on a per-socket basis.

Available as global SNMP mib statistic, not available per-socket.
