Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbQKKIKX>; Sat, 11 Nov 2000 03:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130145AbQKKIKN>; Sat, 11 Nov 2000 03:10:13 -0500
Received: from web1102.mail.yahoo.com ([128.11.23.122]:14349 "HELO
	web1102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130010AbQKKIKG>; Sat, 11 Nov 2000 03:10:06 -0500
Message-ID: <20001111081004.23929.qmail@web1102.mail.yahoo.com>
Date: Sat, 11 Nov 2000 09:10:04 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: Intel's ANS Driver -vs- Bonding [was Re: Linux 2.2.18pre21]
To: Dan Browning <danb@cyclonehq.dnsalias.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, const-g@xpert.com,
        danb@cyclonecomputers.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> EtherChannel.  Supposedly, it also supports failover
> (though even "bonding" driver docs used to say that
> was impossible because the linux networking
subsystem
> didn't handle card failures gracefully enough).

the new bonding code supports failover. It probes the
cards itself. Although this is a recommended mode of
operation, it is not the default one because I want it
to keep fully compatible with any implementation based
on the old one.


>
http://support.intel.com/support/network/adapter/pro100/100Linux.htm

I'll take a look, but except for the XOR sending algo,
I don't think much features are missing.

Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
