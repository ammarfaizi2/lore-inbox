Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWHVJZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWHVJZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWHVJZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:25:27 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:23008 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751083AbWHVJZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:25:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=aHGXkSTA2ZgYJq5KBa07TYiIS4ReVGzzs5oxRxQfaOHOwKB1CXoppkKvZ07WRVrAC77Qpn8qd9jAFj2Ry8wkT1GX+LmQ3e0ST/hrw/o50lDJV9XwwiOQg60wgWY+74xA6Ci3ktfYnU3VLvRZbi584NEaApetfWCq1CZNv7efqYE=
Subject: [2.6.18-rc4-mm2] Compile error in afs
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Aug 2006 09:25:06 +0800
Message-Id: <1156209906.17514.8.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_AFS_FSCACHE=n, I get this compile error:

fs/afs/file.c: In function ‘afs_file_releasepage’:
fs/afs/file.c:332: error: ‘struct afs_vnode’ has no member named ‘cache’
make[2]: *** [fs/afs/file.o] Error 1
make[1]: *** [fs/afs] Error 2
make: *** [fs] Error 2

Tony

