Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271580AbRHPM5K>; Thu, 16 Aug 2001 08:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271579AbRHPM5A>; Thu, 16 Aug 2001 08:57:00 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:55662 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271575AbRHPM4u>; Thu, 16 Aug 2001 08:56:50 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200108161257.f7GCv1C32007@devserv.devel.redhat.com>
Subject: Re: [patch] ips.c spin lock 64 bit issues
To: root@chaos.analogic.com
Date: Thu, 16 Aug 2001 08:57:01 -0400 (EDT)
Cc: ipslinux@us.ibm.com (ServeRAID For Linux), jes@trained-monkey.org,
        alan@redhat.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.3.95.1010816084145.8161A-100000@chaos.analogic.com> from "Richard B. Johnson" at Aug 16, 2001 08:48:43 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think that "unsigned long" is the correct data type.

Wrong.

> Isn't there a data type that means "the largest unsigned integer type
> that fits into a register on the target..."? I was told that that's what

But we don't care. The flags is defined as unsigned long. 

