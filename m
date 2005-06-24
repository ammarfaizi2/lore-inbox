Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFXMZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFXMZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 08:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVFXMZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 08:25:02 -0400
Received: from viefep15-int.chello.at ([213.46.255.19]:24363 "EHLO
	viefep15-int.chello.at") by vger.kernel.org with ESMTP
	id S261266AbVFXMYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 08:24:54 -0400
To: linux-kernel@vger.kernel.org
Subject: GDTH error on 2.6
From: Mario Lang <mlang@delysid.org>
Date: Fri, 24 Jun 2005 14:24:52 +0200
Message-ID: <877jgkndrf.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

After upgrading an existing system from 2.4 to 2.6, we noticed
a strange error message from the DGTH module:

GDT-HA 0: Unknown SCSI command 0x4d to cache service !
SCSI error : <0 0 0 0> return code = 0x50000

Which repeats itself over and over again.

This is with version 3.04 of gdth.c from
2.6.9-5.0.5.ELsmp SMP 686 REGPARM 4KSTACKS gcc-3.4

Has anyone ever seen this behaviour, and perhaps knows a fix for it?

We've already done a controller BIOS upgrade, but the problem did
not go away.

-- 
CYa,
  Mario
