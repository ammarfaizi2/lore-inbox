Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUCCWfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbUCCWfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:35:51 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:41133 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S261219AbUCCWfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:35:50 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild will remove .c files
In-Reply-To: <1vLWC-7h0-1@gated-at.bofh.it>
References: <1vLk4-6uK-23@gated-at.bofh.it> <1vLWC-7h0-1@gated-at.bofh.it>
Date: Wed, 3 Mar 2004 23:35:35 +0100
Message-Id: <E1Ayexk-0000GH-0B@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2004 22:20:06 +0100, you wrote in linux.kernel:

> Two questions pops up though.
> First my make documentatin say the make would use "rm -f ...",not "rm".
> What make version do you use?

I can't find it in the documentation right now, but I believe GNU make
does the unlink(2) itself for intermediate files and only pretends to
be calling rm(1).

-- 
Ciao,
Pascal
