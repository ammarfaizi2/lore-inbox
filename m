Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUAJPqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUAJPqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:46:25 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:24501 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S265206AbUAJPqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:46:24 -0500
Date: Sat, 10 Jan 2004 16:46:22 +0100 (CET)
From: Milan Jurik <M.Jurik@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-mm2: compilation error
Message-ID: <Pine.LNX.4.58.0401101644010.1196@bobek.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    CC      fs/nfs/nfs4proc.o
fs/nfs/nfs4proc.c: In function `nfs4_lck_type':
fs/nfs/nfs4proc.c:2042: warning: control reaches end of non-void function
fs/nfs/nfs4proc.c: In function `nfs4_proc_setlk':
fs/nfs/nfs4proc.c:2189: unknown field `clientid' specified in initializer
fs/nfs/nfs4proc.c:2189: warning: missing braces around initializer
fs/nfs/nfs4proc.c:2189: warning: (near initialization for
`otl.lock_owner')
make[3]: *** [fs/nfs/nfs4proc.o] Error 1
make[2]: *** [fs/nfs] Error 2
make[1]: *** [fs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.1'
make: *** [stamp-build] Error 2

  I can send .config if somebody wants.
  Best regards,

         Milan Jurik
