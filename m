Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbTJULie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTJULid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:38:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43493 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263054AbTJULic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:38:32 -0400
Date: Tue, 21 Oct 2003 13:37:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] updated exec-shield patch, 2.4/2.6 -G4
Message-ID: <Pine.LNX.4.56.0310211330290.6034@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the latest, -G4 update of the exec-shield patches, against various
kernels:

	redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test8-G4
	redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test8-mm1-G4
	redhat.com/~mingo/exec-shield/exec-shield-2.4.22-G4
	redhat.com/~mingo/exec-shield/exec-shield-2.4.22-ac1-nptl-G4

Changes in -G4:

 - bugfix in the 2.6 patches, certain applications segfaulted when the 
   stack limit was set to unlimited. (Roland McGrath)

 - PIE bugfix: for certain ELF layouts the kernel loader ended up 
   overmapping ld.so resulting in broken applications. (Jakub Jelinek, me)

 - port to 2.6.0-test8-mm1. (Valdis Kletnieks, me)

reports, comments welcome. Enjoy it,

	Ingo
