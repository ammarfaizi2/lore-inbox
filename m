Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbTGKSgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbTGKSdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:33:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265003AbTGKSE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:04:29 -0400
Message-Id: <200307111819.h6BIJCr21758@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [OSDL] STP - 2.5.75 + aacraid == bad
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Jul 2003 11:19:12 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we're experiencing system hangs on STP systems testing
the 2.5.75 series, with the aacraid driver. 

Systems hang and freeze when attempting to mkfs, sometimes 
when idle. Happening so far on baseline and -mm* kernels.

STP will be a little late delivering results for this series,
you'll notice if you check Linstab
 - I think we're going to change the default config to 'elevator=deadline'
so we can get some runs through.

cliffw



