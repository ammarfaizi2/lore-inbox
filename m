Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265907AbUF3Syn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUF3Syn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUF3Syn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:54:43 -0400
Received: from areq.eu.org ([212.191.78.132]:9746 "EHLO ix.p.lodz.pl")
	by vger.kernel.org with ESMTP id S265907AbUF3Syk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:54:40 -0400
From: Arkadiusz Patyk <areqlkl@areq.eu.org>
To: linux-kernel@vger.kernel.org
Subject: initramfs and kernel  2.6.7
Date: Wed, 30 Jun 2004 20:55:02 +0200
Message-ID: <r236e0tp11ek1q0rh5912e423mc78qio5g@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scan-Signature: 43d3d95615390a7043daff8d5b4bd9ad
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I 'am trying to launch linux kernel 2.6.7 with initramfs.

My pxelinux.cfg/default file looks as follows:
default a1
prompt 1
timeout 600
label a1
kernel vmlinuz-2.6.7-1
append initrd=initramfs_data.cpio.gz root=/dev/ram0 init=/linuxrc

Kernel image  vmlinuz-2.6.7-1 and  initramfs_data.cpio.gz was loaded 
succesfully by pxelinux.

Kernel says:
checking if image is initramfs... it is

but later occurs an error:
Kernel panic: VFS: Unable to mount root fs on ram0

Full log: http://rescuecd.pld-linux.org/minicom.cap

What should I do to run my system? 
Maybe root=/dev/ram0 is not correct?

Best regards,
-- 
Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org/]
[IRC:areq ICQ:16231667  GG:1383]  [AP3-6BONE] [AP14126-RIPE]
