Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131514AbRCNTz5>; Wed, 14 Mar 2001 14:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131513AbRCNTzr>; Wed, 14 Mar 2001 14:55:47 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:65291 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131512AbRCNTzg>;
	Wed, 14 Mar 2001 14:55:36 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103141950.WAA14397@ms2.inr.ac.ru>
Subject: Re: poll() behaves differently in Linux 2.4.1 vs. Linux 2.2.14 (POLLHUP)
To: davem@redhat.COM (David S. Miller)
Date: Wed, 14 Mar 2001 22:50:04 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15022.53815.129522.746120@pizda.ninka.net> from "David S. Miller" at Mar 14, 1 05:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> True, this behavior was changed from 2.2.x.  We now match the behavior
> of other svr4 systems, in particular Solaris.

Damn, we did not test behaviour on absolutely new clean never
connected socket... Solaris really may return 0 on it.

However, looking from other hand the issue looks as absolutely
academic and not related to practice in any way.

Alexey
