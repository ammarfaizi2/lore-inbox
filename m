Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUB2Xvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 18:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUB2Xvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 18:51:54 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:31442 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262187AbUB2Xvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 18:51:53 -0500
Date: Mon, 1 Mar 2004 00:51:50 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Is the 2.6 dependency information complete? Doesn't look so...
Message-ID: <20040229235150.GA6327@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just seen, after a BK pull:

  CC      fs/nfsd/nfsctl.o
fs/nfsd/nfsctl.c:28:30: linux/nfsd_idmap.h: no such file or directory

This is a hint the dependency information isn't complete, otherwise, GNU
make would've "get"^Wgot the include file.

Will the kernel rebuild dependent files when includes change when this
information is missing? If so, how?

TIA,

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
