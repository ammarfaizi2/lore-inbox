Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVAGQOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVAGQOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVAGQOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:14:46 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:33448 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261481AbVAGQOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:14:45 -0500
Message-Id: <200501071614.j07GEgEC018705@localhost.localdomain>
To: Martin Mares <mj@ucw.cz>
cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 17:08:08 +0100."
             <20050107160808.GB6529@ucw.cz> 
Date: Fri, 07 Jan 2005 11:14:42 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 10:14:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sure, filesystem capabilities would be nice, but for the stuff Paul
>mentions they aren't needed -- what you need is to grant capabilities
>to the user's session, which can be easily done by a PAM module.

i think this is true only if the kernel comes with capabilities
enabled.

various media-centric distributions (CCRMA, demudi, dyne:bolic and
others) enabled them for their 2.4 kernels, but not the major
desktop-centric ones. then the impression began to be received that in
2.6, capabilities were even more questionable of a mechanism to use.
In addition, the LSM system appeared, and seemed to offer a much
better solution entirely: no need to patch the kernel at all, or at
least it appeared to be so in the beginning. Hence the "realtime" LSM.

--p
