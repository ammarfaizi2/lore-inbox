Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272050AbTHHWGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272066AbTHHWGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:06:37 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36868 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272050AbTHHWEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:04:54 -0400
Date: Sat, 9 Aug 2003 00:03:03 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH] TRY #2 - 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm
Message-ID: <20030809000303.A2699@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  followup to the posting of 2003/07/09. Patchkit is still divided in 8 parts:

1 - devices;
2 - utility and common code for vcs (vc/pvc/svc);
3 - pvc;
4 - svc;
5 - vc;
6 - arp;
7 - lec;
8 - final cleanup.

Gross bugs have been fixed in #7. It now passes some basic testing. Its
behavior with a huge number of lec remains to be proved. Others parts
already seemed quite nice last month.

--
Ueimor
