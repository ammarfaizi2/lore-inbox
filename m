Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270651AbTHJUln (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270655AbTHJUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:41:43 -0400
Received: from AMarseille-201-1-6-8.w80-11.abo.wanadoo.fr ([80.11.137.8]:13095
	"EHLO gaston") by vger.kernel.org with ESMTP id S270651AbTHJUll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:41:41 -0400
Subject: Re: HFS error messages in 2.6.0-test3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: oliver@neukum.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308102034.h7AKYJsr014788@harpo.it.uu.se>
References: <200308102034.h7AKYJsr014788@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060548071.599.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 22:41:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> (I install new kernels in a MacOS9/HFS partition because BootX
> is the only boot loader that works on my OldWorld PowerMac.)

The "old" HFS filesystem is in serious need of some in-depth auditing
I'm afraid... In the meantime, I'd suggest using the userland hfsutils.

Note: the new hfsplus filesystem from Roman Zippel seems quite solid
now and is in 2.4.22-pre, hopefully, Roman will get it in 2.6 soon...

Ben.

