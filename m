Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUBDNAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 08:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUBDNAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 08:00:20 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:2714 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261889AbUBDNAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 08:00:16 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: Reserved pages not flagged on Compaq evo?
Date: Wed, 4 Feb 2004 20:36:13 +0800
User-Agent: KMail/1.5.4
Cc: swsusp-devel@lists.sourceforge.net
References: <87llnyggfm.fsf@larve.net> <200402030614.37454.mhf@linuxmail.org> <20040204114113.GA1110@home.larve.net>
In-Reply-To: <20040204114113.GA1110@home.larve.net>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402042024.47784.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A 2.4.24 + swsusp 2.0 user reported a mce at the video base address
of 0xa0000 when writing the kernel image to disk (thus reading there)
on a Compaq evo1015v (Athlon XP 2000+)

NOMCE eliminates the mce but I am wondering about possible ill effects
should other reserved pages be invalidly accessed.
  
It looks like these pages are not flagged reserved and therfore accessed. 

No other mce's have ever been reported.

What is the suggested approach to identify the root cause?

Michael


