Return-Path: <linux-kernel-owner+w=401wt.eu-S1754959AbWL1UgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbWL1UgL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbWL1UgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:36:11 -0500
Received: from [139.30.44.16] ([139.30.44.16]:22963 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754964AbWL1UgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:36:10 -0500
Date: Thu, 28 Dec 2006 21:36:09 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
In-Reply-To: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.63.0612282132500.8527@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After fiddling with this patch for so long, I forgot to mention an 
important thing:
This time the patch only includes things that need no fixups at all (most 
of these already went in last time).

So all hunks are independent, and you can just drop anything that does not 
apply or causes any other trouble. 

Thanks,
Tim
