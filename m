Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbUKPUr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbUKPUr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUKPUr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:47:26 -0500
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:44750
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S261790AbUKPUqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:46:10 -0500
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: pthread_cond_signal not waking thread
Date: Tue, 16 Nov 2004 15:45:56 -0500
Message-ID: <NFBBICMEBHKIKEFBPLMCKEPHJMAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <16794.25535.97260.366902@thebsh.namesys.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nikita:

I am running 2.6.10-rc1-bk7 ... what version of the kernel are you talking about?  The link you included does not work.

A.

-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com]
Sent: Tuesday, November 16, 2004 3:32 PM
To: Andrew A.
Cc: linux-kernel@vger.kernel.org
Subject: Re: pthread_cond_signal not waking thread


Andrew A. writes:
 > 
 > 
 > Below is a sysrq-t dump (relevant process is called "tt1"), and a
 > post I sent to ACE user group describing a situation I am seeing
 > where a pthread_cond_signal() call sometimes does not wake up the
 > thread waiting on the condition variable, despite a call to
 > sched_yield() following the pthread_cond_signal().  All threads are
 > running at equal priorities under SCHED_RR.
 > 

I experienced similar thing. Switching to the latest
http://linux.bkbits.net/linux-2.5 (done about 10 hours ago), (as advised
by Arjan van de Ven) fixed it.

Nikita.



