Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSFHXIA>; Sat, 8 Jun 2002 19:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSFHXH7>; Sat, 8 Jun 2002 19:07:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65449 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317469AbSFHXH6>;
	Sat, 8 Jun 2002 19:07:58 -0400
Date: Sat, 08 Jun 2002 16:04:07 -0700 (PDT)
Message-Id: <20020608.160407.101346167.davem@redhat.com>
To: mark@mark.mielke.cc
Cc: greearb@candelatech.com, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020608170511.B26821@mark.mielke.cc>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You guys we have SNMP statistics for these events, there
is no reason to have them per-socket.  You cannot convince
me that when you are diagnosing a problem the SNMP stats
are not enough to show you if the packets are being dropped.

If not, this means we need to add more SNMP events, that is
all it means.
