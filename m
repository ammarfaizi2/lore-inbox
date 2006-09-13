Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWIMTiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWIMTiy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWIMTiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:38:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56028 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751156AbWIMTix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:38:53 -0400
Subject: Re: Assignment of GDT entries
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
In-Reply-To: <1158175001.3054.7.camel@laptopd505.fenrus.org>
References: <450854F3.20603@goop.org>
	 <1158175001.3054.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Sep 2006 21:00:47 +0100
Message-Id: <1158177647.16902.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-13 am 21:16 +0200, ysgrifennodd Arjan van de Ven:
> I don't know the exact details on these; I do know that several GDT
> entries tend to be used by BIOSes in their APM implementations and thus
> are better of not being used.

Thats 0x40 which tends to get used as if was a real mode base for BIOS
accesses even via the protected mode interface.

Alan

