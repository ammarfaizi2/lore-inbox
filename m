Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291625AbSCDFTC>; Mon, 4 Mar 2002 00:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291664AbSCDFSx>; Mon, 4 Mar 2002 00:18:53 -0500
Received: from barkley.vpha.health.ufl.edu ([159.178.78.160]:22213 "EHLO
	barkley.vpha.health.ufl.edu") by vger.kernel.org with ESMTP
	id <S291625AbSCDFSo>; Mon, 4 Mar 2002 00:18:44 -0500
Message-ID: <1015219129.3c8303b9e87a7@webmail.health.ufl.edu>
Date: Mon,  4 Mar 2002 00:18:49 -0500
From: sridharv@ufl.edu
To: linux-kernel@vger.kernel.org
Subject: interrupt - spin lock question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 66.157.144.214
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question related to spin locking on UP systems.Before that I would 
like to point out my understanding of the background stuff
1. spinlocks shud be used in intr handlers
2. interrupts can preempt kernel code
3. spinlocks are turned to empty when kernel is compiled without SMP support.

If a particular driver is running( not the intr handler part) and at this time 
an interrupt occurs. The handler has to be invoked now. Won't the preemption 
cause race conditions/inconsistencies? Is any other mechanism used?
Pl correct me if I have not understood any part of this correctly
-sridhar



