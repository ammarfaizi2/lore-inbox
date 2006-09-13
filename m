Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWIMVNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWIMVNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWIMVNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:13:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10397 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751187AbWIMVNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:13:06 -0400
Subject: Re: Assignment of GDT entries
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
In-Reply-To: <4508711B.6060905@vmware.com>
References: <450854F3.20603@goop.org>
	 <1158175001.3054.7.camel@laptopd505.fenrus.org> <4508681E.3070708@goop.org>
	 <4508711B.6060905@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Sep 2006 22:35:21 +0100
Message-Id: <1158183322.16902.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-13 am 13:59 -0700, ysgrifennodd Zachary Amsden:
> TLS #3 overlaps BIOS 0x40, but code which calls borken APM / PnP BIOS 
> and sets up protected mode 0x40 GDT segment does so by swapping out the 
> TLS segment with the identity simulation of physical 0x400 offset, 
> swapping it back afterwards.  Short of bugs in that code (which there 
> are, btw), you shouldn't need to be concerned with it.

Care to elucidate ?


