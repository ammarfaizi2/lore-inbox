Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263028AbREWJaH>; Wed, 23 May 2001 05:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263029AbREWJ35>; Wed, 23 May 2001 05:29:57 -0400
Received: from [212.150.138.2] ([212.150.138.2]:40721 "EHLO
	ntserver.voltaire.com") by vger.kernel.org with ESMTP
	id <S263028AbREWJ3q>; Wed, 23 May 2001 05:29:46 -0400
Message-ID: <20083A3BAEF9D211BDB600805F8B14F3AE37D7@NTSERVER>
From: Aviv Greenberg <avivg@voltaire.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: softirq question
Date: Wed, 23 May 2001 12:26:49 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it possible to enter into sleep mode 
( current->state = !RUNNING && schedule(_timeout))
from a softirq ?

It is not a real hardware interrupt after all, but it still runs in
the context of a running process....

Aviv Greenberg // sizeof(void)
http://www.voltaire.com


