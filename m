Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTAGMor>; Tue, 7 Jan 2003 07:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbTAGMor>; Tue, 7 Jan 2003 07:44:47 -0500
Received: from services.cam.org ([198.73.180.252]:57119 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267125AbTAGMoq> convert rfc822-to-8bit;
	Tue, 7 Jan 2003 07:44:46 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: unknown symbols 2.5.54bk (soundcore/errno nfsd/hash_mem)
Date: Tue, 7 Jan 2003 07:53:34 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Message-Id: <200301070753.34476.tomlins@cam.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this doing modules_install this morning:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.54; fi
WARNING: /lib/modules/2.5.54/kernel/sound/soundcore.ko needs unknown symbol errno
WARNING: /lib/modules/2.5.54/kernel/fs/nfsd/nfsd.ko needs unknown symbol hash_mem

Suspect Neil Brown will fix hash_mem once his patch gets past the Linus filter.  I
have not seen the second reported.  I do not have ALSA selecterd, just OSS.

Ed Tomlinson
