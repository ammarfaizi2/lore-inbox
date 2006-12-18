Return-Path: <linux-kernel-owner+w=401wt.eu-S1753801AbWLRK7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbWLRK7e (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbWLRK7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:59:34 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:51428 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801AbWLRK7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:59:33 -0500
Date: Mon, 18 Dec 2006 11:50:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Chris Zubrzycki <chris@middle--earth.org>, Adrian Bunk <bunk@stusta.de>,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       Aleksandr Koltsoff <czr@iki.fi>
Subject: Re: [GFS2] Fix Kconfig [2/2]
In-Reply-To: <1166435849.3752.1266.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0612181149420.22591@yvahk01.tjqt.qr>
References: <1166435650.3752.1263.camel@quoit.chygwyn.com>
 <1166435849.3752.1266.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 18 2006 09:57, Steven Whitehouse wrote:
> config GFS2_FS_LOCKING_DLM
> 	tristate "GFS2 DLM locking module"
>-	depends on GFS2_FS
>+	depends on GFS2_FS && NET && INET && (IPV6 || IPV6=n)

What is this supposed to do? IPV6 || IPV6=n is a tautology AFAICS.


	-`J'
-- 
