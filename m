Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSHTUfj>; Tue, 20 Aug 2002 16:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSHTUfi>; Tue, 20 Aug 2002 16:35:38 -0400
Received: from host.greatconnect.com ([209.239.40.135]:26116 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S317299AbSHTUfi>; Tue, 20 Aug 2002 16:35:38 -0400
Subject: Linux 2.4.20-pre4 depmod errors
From: Samuel Flory <sflory@rackable.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208191944210.10105-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44.0208191944210.10105-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 13:38:51 -0700
Message-Id: <1029875932.5308.100.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

minor depmod issues:

[root@gorn linux-2.4.20-pre4]# /sbin/depmod -ae -F System.map 
2.4.20-pre4
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre4/kernel/drivers/media/radio/miropcm20.o
depmod:         aci_rw_cmd_Rsmp_cc7c4cd8
depmod:         aci_port_Rsmp_0d82adb6
depmod:         aci_version_Rsmp_93350c87
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre4/kernel/drivers/media/video/bttv.o
depmod:         mod_firmware_load_Rsmp_39e3dd23
[root@gorn linux-2.4.20-pre4]# 



