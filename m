Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVBAFpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVBAFpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVBAFpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:45:16 -0500
Received: from vsmtp14.tin.it ([212.216.176.118]:58861 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S261576AbVBAFpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:45:06 -0500
Subject: kernel crash using XFS over raid5 partition
From: Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Giuseppe Sacco Consulting
Date: Tue, 01 Feb 2005 06:44:47 +0100
Message-Id: <1107236687.3722.89.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am facing a kernel bug[1] that completely crashes my machines. During
the last days I tried to fine tune the problem and I am now inclined for
a bug in libata/sata_sil or device mapper code.

I activated the DEBUG messages in raid5 source module, but I cannot find
a way to do the same with libata. Is there any #define I may use?

Thanks,
Giuseppe

[1]http://bugme.osdl.org/show_bug.cgi?id=3968

