Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270820AbTGPJie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 05:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270822AbTGPJie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 05:38:34 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19216 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S270820AbTGPJid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 05:38:33 -0400
Date: Wed, 16 Jul 2003 11:53:21 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: LVM2 user space, device mapper, Linux 2.4/2.6 dual boot no-go.
Message-ID: <20030716095321.GF27177@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

here's the situation:

I want to test drive 2.6, have 2.4.22-pre3-ac1 with LVM1, Device Mapper
and XFS. I tried LVM2 user space on 2.4.22, it complained about ioctl
mismatch (wants 4.x.y, gets 1.m.n). Do I need to disable LVM1?

On 2.6, lvm lvmdiskscan works, but lvm vgscan stuffs my screen with
"modprobe junk.", so I reverted to 2.4-with-LVM1-user-space for now.

Has anyone had success with running the same user-space LVM2 stuff on
2.4 and 2.6? Which versions of device-mapper and LVM2 do you use for
that purpose? What are the magic switches in Linux-2.4.22-preX-acY?

Help appreciated.

-- 
Matthias Andree
