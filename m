Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRI2JzD>; Sat, 29 Sep 2001 05:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276474AbRI2Jyw>; Sat, 29 Sep 2001 05:54:52 -0400
Received: from chiara.elte.hu ([157.181.150.200]:33040 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S273831AbRI2Jyo>;
	Sat, 29 Sep 2001 05:54:44 -0400
Date: Sat, 29 Sep 2001 11:52:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <3BB52510.7D41538A@osdlab.org>
Message-ID: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sorry :-) definitions of netconsole-terms:

'server': the host that is the source of the messages. Ie. the box that
          runs the netconsole.o module. It serves log messages to the
          client.

'client': the host that receives the messages. This box is running the
          netconsole-client.c program.

'target': the host that gets the messages sent - ie. the client.

'target IP address': the IP address of the 'target'.

'target ethernet address': the local-net host or first-hop router that
                           gets the netconsole UDP packets sent. Ie. it
                           does not necesserily match the MAC address of
                           the 'target'.

(i can see where the confusion comes from, 'syslog servers' are ones that
receieve syslogs. It's a backwards term i think. 'netconsole servers' are
the ones that produce the messages.)

does it make more sense now? :)

	Ingo

