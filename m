Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVLULdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVLULdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVLULdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:33:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29338 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932371AbVLULdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:33:17 -0500
Subject: Re: [RFC] TOMOYO Linux released!
From: Arjan van de Ven <arjan@infradead.org>
To: Tetsuo Handa <from-kernelnewbies@I-love.SAKURA.ne.jp>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <200512212020.FBF94703.XOTMFStFPCJNSFLFOG@I-love.SAKURA.ne.jp>
References: <200512212020.FBF94703.XOTMFStFPCJNSFLFOG@I-love.SAKURA.ne.jp>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 12:33:13 +0100
Message-Id: <1135164793.3456.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 20:21 +0900, Tetsuo Handa wrote:
> Hello!
> 
> A new and easy to master access control for Linux,
> TOMOYO Linux, is now available.


very interesting; a few quick questions that I didn't see answered on
the side

1) where can we download the patches?

2) How does the use of "absolute paths" interact with namespaces?
   In principle each process can have its own namespace after all!
   (not many distributions use this today, but that will change soon,
   per user /tmp is a very attractive feature and all needed
   infrastructure helpers for this will be in the 2.6.15 kernel)


