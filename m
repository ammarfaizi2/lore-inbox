Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280203AbRJaNfQ>; Wed, 31 Oct 2001 08:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280199AbRJaNfG>; Wed, 31 Oct 2001 08:35:06 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:50181 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S280202AbRJaNez>;
	Wed, 31 Oct 2001 08:34:55 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110311334.QAA01756@ms2.inr.ac.ru>
Subject: Re: iptables and tcpdump
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 31 Oct 2001 16:34:32 +0300 (MSK)
Cc: davem@redhat.com, fokkensr@linux06.vertis.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20011031172835.4f0c0ed2.rusty@rustcorp.com.au> from "Rusty Russell" at Oct 31, 1 05:28:35 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Agreed.  The 2.2 masq code didn't do this, and hence the "don't tcpdump on masq host"
> recommendation.

Paul, it is very possible that I smoke/drunk something wrong
and saw this in dreams, but I really remember that this bug
has been fixed in some 2.1.x. :-)

Only function is different: that time skb_unshare() did some
unitelligible thing and was used only by AX.25 for an unknown purpose.
So, the function which does the work was called skb_cow().

Alexey
