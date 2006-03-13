Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWCMPA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWCMPA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWCMPA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:00:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10626 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751373AbWCMPA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:00:57 -0500
Subject: New libata PATA patch for 2.6.16-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Mar 2006 15:07:10 +0000
Message-Id: <1142262431.25773.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available from 

http://zeniv.linux.org.uk/~alan/IDE/


Main changes:
	Various drivers moved to use SRST
	Probe code now knows about 0xFF return due to missing pulldowns
		on cheap controllers
	HPT37x masking bug fixed
	Try to issue LBA28 commands whenever possible
	Above should fix ALi speed problems
	VIA ATAPI now works for me
	IT8212 prints raid data
	Fix IT8212 sector clamping
	Report aborted command for unknown errors
	Fix HPT371 crash on probe

