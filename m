Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVEFOYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVEFOYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVEFOYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:24:04 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:12175 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261241AbVEFOXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:23:54 -0400
Message-Id: <200505061423.j46ENfTG024192@ginger.cmf.nrl.navy.mil>
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
cc: Willy Tarreau <willy@w.ods.org>, openafs-info@openafs.org,
       linux-kernel@vger.kernel.org
Reply-To: chas3@users.sourceforge.net
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82 
In-reply-to: <Pine.LNX.4.62.0505061024070.450@tassadar.physics.auth.gr> 
Date: Fri, 06 May 2005 10:23:42 -0400
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.62.0505061024070.450@tassadar.physics.auth.gr>,Dimitris 
Zilaskos writes:
>May  6 04:55:29 system kernel: kernel BUG at inode.c:1204!

looks like you might have one of those kernels with extra bits (in
particular, i_notify).  please try a later version of afs like 1.3.81.
