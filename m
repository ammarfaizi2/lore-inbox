Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbRERDrm>; Thu, 17 May 2001 23:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbRERDrb>; Thu, 17 May 2001 23:47:31 -0400
Received: from css-1.cs.iastate.edu ([129.186.3.24]:18954 "EHLO
	css-1.cs.iastate.edu") by vger.kernel.org with ESMTP
	id <S262243AbRERDrV>; Thu, 17 May 2001 23:47:21 -0400
Date: Thu, 17 May 2001 22:47:17 -0500 (CDT)
From: "C.Praveen" <cpraveen@cs.iastate.edu>
To: <linux-kernel@vger.kernel.org>
cc: Praveen Codambakkam <cpraveen@cs.iastate.edu>
Subject: Question
Message-ID: <Pine.HPX.4.31.0105172238460.10687-100000@havok.cs.iastate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i have a very simple question.
please CC any reply to me, since im not subscribed to the list


On the same processor i have the following code (initially a = 0)

1. write a = 1
2. read b

if an interrupt occurred after line 1 and before line 2, and that ISR
reads the value of a, is there a chance it can see the value of a as 0?
Hope the question isnt too stupid, but the processor can buffer stores to
memory ? (Does it supply the correct value of a to the isr if it does). if
not, mb wont solve the problem i suppose? its meant for other cpus ?

Thanks,

Praveen C

