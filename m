Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266440AbUBLOGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266445AbUBLOGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:06:10 -0500
Received: from [194.67.69.111] ([194.67.69.111]:8069 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S266440AbUBLOGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:06:08 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200402121405.RAA09466@yakov.inr.ac.ru>
Subject: Re: [Patch] Netlink BUG() on AMD64
To: davem@redhat.com (David S. Miller)
Date: Thu, 12 Feb 2004 17:05:44 +0300 (MSK)
Cc: yoshfuji@linux-ipv6.org, kas@informatics.muni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040211194909.0ab130cc.davem@redhat.com> from "David S. Miller" at Feb 11, 2004 07:49:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I was tempted to make skb_put()'s second argument signed, but I'm in no mood
> to audit the entire tree for that :-)

No, no, it really was just a silly mistake, misprint most likely,
skb_put() was expected to eat only positive arguments.

Alexey

