Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132137AbRCYR4X>; Sun, 25 Mar 2001 12:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132139AbRCYR4M>; Sun, 25 Mar 2001 12:56:12 -0500
Received: from fe040.world-online.no ([213.142.64.154]:42489 "HELO
	mail.world-online.no") by vger.kernel.org with SMTP
	id <S132137AbRCYRz4>; Sun, 25 Mar 2001 12:55:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Gerry <gerry@c64.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
Date: Sun, 25 Mar 2001 19:55:15 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <UTC200103251231.OAA10795.aeb@vlet.cwi.nl>
In-Reply-To: <UTC200103251231.OAA10795.aeb@vlet.cwi.nl>
MIME-Version: 1.0
Message-Id: <01032519492002.00897@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, i don't really know much about the kernel at all, but here's my opinion 
anyway..

To use 64bit pids when 32bit is enough just to "make things easier" doesn't 
sound like a good idea to me. Eventually it might wrap around (fx. as on that 
supercomputer Jamie Lokier talked about) to overwrite running processes, and 
cause death and destruction. Bye bye stability.

Even if it doesn't wrap, using double the space necessarry for something 
every single process has is a waste of space. Linux is supposed to be able to 
run on a large range of systems, and some of them don't have that kind of 
luxury. Sure, the kernel can be modified for those (rare) cases, but still, 
using something that's not necessary just sounds like bad practice to me.. 

Never assume luxury..

Gerry
