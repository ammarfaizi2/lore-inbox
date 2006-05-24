Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWEXJss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWEXJss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 05:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWEXJss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 05:48:48 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:46777 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S932609AbWEXJss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 05:48:48 -0400
To: hpa@zytor.com
CC: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: UML boot failure with kinit
Message-Id: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 May 2006 11:48:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML now compiles on 2.6.17-rc4-mm3, but it fails to boot:

[...]
kinit: do_mounts
kinit: name_to_dev_t(98:0) = dev(0,0)
kinit: root_dev = dev(0,0)
kinit: trying to mount /dev/root on /root with type ext3
kinit: Cannot open root device dev(0,0)
[...]

Adding 'root=ubda' to the command line cures it.

Miklos
