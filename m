Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbUKPAZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUKPAZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 19:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUKPAZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 19:25:32 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:38252 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261725AbUKPAZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 19:25:27 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Why INSTALL_PATH is not /boot by default?
Date: Tue, 16 Nov 2004 01:27:15 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411160127.15471.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This line, in the main Makefile, is commented:

export  INSTALL_PATH=/boot

Why? It seems pointless, since almost everything has been for ages requiring 
this settings, and distros' versions of installkernel have been taking an 
empty INSTALL_PATH as meaning /boot for ages (for instance Mandrake). It's 
maybe even mandated by the FHS (dunno).

Is there any reason I'm missing?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
