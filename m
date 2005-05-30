Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVE3ULL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVE3ULL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVE3ULK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:11:10 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:41426 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261735AbVE3ULG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:11:06 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Assertion failure in log_do_checkpoint() and the fix
From: Alexander Nyberg <alexn@telia.com>
To: sct@redhat.com, akpm@osdl.org, jack@suse.cz
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 30 May 2005 22:10:58 +0200
Message-Id: <1117483858.956.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was brought up earlier at http://lkml.org/lkml/2005/5/6/30

Is there any reason for this one-liner to not go into mainline? It
appears to fix up a quite nasty failure. Even if it is not the real
correct long term solution it has to be better than having boxes
panic'ing under certain loads?

I'm clueless about this but it does appear to fix my bug and others have
hit this aswell. (apologies if this has been fixed in another way,
haven't seen any jbd/ext3 patches in a while)

