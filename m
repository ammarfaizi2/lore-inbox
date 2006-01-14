Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423221AbWANAkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423221AbWANAkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423242AbWANAku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:40:50 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:13230 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1423221AbWANAku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:40:50 -0500
Message-Id: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:48 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] fuse: fixes, cleanups and asynchronous read requests
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains recent fixes and cleanups to FUSE.  The bigger
part is the support for asynchronous reads.  This will be a big
performance improvement of filesystems in certain situations due to
the readahead logic being able to work to it's full capability.  

I'd prefer to have this in 2.6.16.  The merge window is still open,
isn't it?

Thanks,
Miklos
