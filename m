Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264452AbUFLAit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUFLAit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUFLAit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:38:49 -0400
Received: from smtp08.auna.com ([62.81.186.18]:53692 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S264452AbUFLAis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:38:48 -0400
Date: Sat, 12 Jun 2004 02:38:46 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Invalid module format ?
Message-ID: <20040612003846.GA4275@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

First of all, I'm aware of the 'ask the vendor' answer. I just would like
the reasons.

With gcc-3.4.1 cvs, the nvidia module is miscompiled or something.
The same sources that build and install with gcc-3.3, now build and give
me this:

werewolf:~# modinfo nvidia
filename:       /lib/modules/2.6.7-rc3-jam1/video/nvidia.ko
license:        NVIDIA
werewolf:~# modprobe nvidia
FATAL: Error inserting nvidia (/lib/modules/2.6.7-rc3-jam1/video/nvidia.ko): Invalid module format

syslog:

Jun 12 02:35:44 werewolf kernel: No module found in object

werewolf:~# cat /proc/version
Linux version 2.6.7-rc3-jam1 (root@werewolf.able.es) (gcc version 3.4.1 (Mandrakelinux (Cooker) 3.4.1-0.2mdk)) #1 SMP Fri Jun 11 01:49:52 CEST 2004

Any idea ?


-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrakelinux release 10.1 (Cooker) for i586
Linux 2.6.7-rc3-jam1 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-0.2mdk)) #1
