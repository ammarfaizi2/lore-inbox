Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTLBQjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTLBQjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:39:02 -0500
Received: from thumper2.emsphone.com ([199.67.51.102]:27819 "EHLO
	thumper2.emsphone.com") by vger.kernel.org with ESMTP
	id S262386AbTLBQjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:39:00 -0500
Date: Tue, 2 Dec 2003 10:38:56 -0600
From: Andrew Ryan <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: ide-cd 2.6.0-test11 does not work
Message-ID: <20031202163856.GA16759@thumper2.emsphone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The docs say I shouldn't need ide-scsi anymore, but ide-scsi is the only way
I can mount cds.  If I try mount /dev/hdc /mnt I get /dev/hdc is not a valid
block device.  After loading ide-scsi, mount /dev/sr0 /mnt works fine
(though if I rip music cds with xcdroast the system locks up, ide-scsi
related oops).  This is on a hp zd7000 notebook with a dvd/cd-rw
(HL-DT-STCD-RW/DVD DRIVE GCC-4241N).

Andy


