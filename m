Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbULNHYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbULNHYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 02:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbULNHYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 02:24:25 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:40395 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261439AbULNHYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 02:24:22 -0500
Message-ID: <24338756.1103009050547.JavaMail.tomcat@pne-ps1-sn1>
Date: Tue, 14 Dec 2004 08:24:10 +0100 (MET)
From: Voluspa <lista4@comhem.se>
Reply-To: lista4@comhem.se
To: mr@ramendik.ru
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [213.64.150.229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2004-12-14 2:28:59 Mikhail Ramendik wrote:

> BTW, somebody told me in a private email to try the oomkiller patch, but 
I 
> could not extract it from the Web archive, so I don't have the latest version 
> of that :( I'd apreciate if anyone emailed that to me, or gave me a link. 
or 
> a pointer to instructions on getting it right from obe of the Web archives.

Final incarnation can be picked up at
http://marc.theaimsgroup.com/?l=linux-kernel&m=110269783227867&w=2

But on my machine it doesn't address the issue you speak of. When I run something
as demanding as that (end of memory, eating a large chunk of swap) it behaves 
like
yours. Gkrellm stops - no screen updates, mouse becomes very unresponsive etc. 
Though
I saw that as "normal" for the workload.

In this appartment there's no difference between 2.6.9 patched with the kswapd 
fix and
the oomkill patch, or 2.6.10-rc3 with or without oomkill patch. Can't comment 
on 2.6.8
since I didn't exhaust memory with applications back then.

Mvh
Mats Johannesson

