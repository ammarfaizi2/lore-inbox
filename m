Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRJ3RcD>; Tue, 30 Oct 2001 12:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJ3Rb4>; Tue, 30 Oct 2001 12:31:56 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:7687 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277047AbRJ3RbG>;
	Tue, 30 Oct 2001 12:31:06 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110301731.UAA19307@ms2.inr.ac.ru>
Subject: Re: iptables and tcpdump
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 30 Oct 2001 20:31:05 +0300 (MSK)
Cc: fokkensr@linux06.vertis.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20011030152812.2e9ba8ee.rusty@rustcorp.com.au> from "Rusty Russell" at Oct 30, 1 03:28:12 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey, should the NAT layer be doing skb_unshare() before altering the packet?

MUST. Cloned skbs are read-only.

I did not expect such question from you. :-)

Alexey
