Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTFLJLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTFLJLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:11:22 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:57609 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262601AbTFLJLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:11:17 -0400
Date: Thu, 12 Jun 2003 11:24:58 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: SCSI Write Cache Enable in 2.4.20?
Message-ID: <20030612092458.GA29060@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I haven't followed the status of write barrier patches recently, I am
wondering if it's still "necessary" (to avoid file system corruption) to
disable the write cache of a SCSI disk drive when the machine doesn't
have an uninterruptible power supply or if instead the file systems and
driver know how to use ordered tags.  (Fujitsu MAP drive: 8 MB cache,
AIC7880 adapter, SuSE Linux 8.2 patched 2.4.20 kernel with ext3 and xfs)

TIA,

-- 
Matthias Andree
