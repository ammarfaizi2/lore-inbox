Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268723AbTCCTEL>; Mon, 3 Mar 2003 14:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268722AbTCCTEL>; Mon, 3 Mar 2003 14:04:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3756 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268720AbTCCTEJ>;
	Mon, 3 Mar 2003 14:04:09 -0500
Date: Mon, 03 Mar 2003 10:56:46 -0800 (PST)
Message-Id: <20030303.105646.02089773.davem@redhat.com>
To: cfriesen@nortelnetworks.com
Cc: terje.eggestad@scali.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: anyone ever done multicast AF_UNIX sockets?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E63A8CB.2090307@nortelnetworks.com>
References: <3E6399F1.10303@nortelnetworks.com>
	<20030303.095641.87696857.davem@redhat.com>
	<3E63A8CB.2090307@nortelnetworks.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Friesen <cfriesen@nortelnetworks.com>
   Date: Mon, 03 Mar 2003 14:11:07 -0500
   
   I haven't done UDP bandwidth testing--I need to check how lmbench
   did it for the unix socket and do the same for UDP.  Local TCP was
   far slower than unix sockets though.

That result is system specific and depends upon how the data and
datastructures hit the cpu cachelines in the kernel.

TCP bandwidth is slightly faster than AF_UNIX bandwidth on my
sparc64 boxes for example.
