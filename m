Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVHAN3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVHAN3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 09:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVHAN24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 09:28:56 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:41526 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261919AbVHAN2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 09:28:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=DxMBmmxA9q8u+lY/BIr2veGSSjVGLkJS/yvON1ZldksAWswdF2GZZx4sN3zm3ycHpWowM/epeCvM5svLJ5c4HHw/Y4nC1WcVaTHwZT2MviMX10HgkN1FgDEuayS9T+9tNZm05fxoqLBlMao3PZkYmFs3ydCEfMgC/rRxIh9A7Rw=
Message-ID: <42EE238F.4050900@gmail.com>
Date: Mon, 01 Aug 2005 22:28:47 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: git@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       snemana@yahoo.com, paulus@samba.org, rdunlap@xenotime.net,
       mingo@elte.hu
Subject: [ANNOUNCE] mtkdiff-20050801 (with patchkdiff, quiltkdiff, gitkdiff
 and modified gitk)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, guys.

New version of mtkdiff package is available.  Changes since last release 
(20050514) are.

* patchkdiff added.  Idea is from patchview of Randy Dunlap (Hi!).
   patchkdiff can show multiple diff files.

* quiltkdiff rewritten in perl.  It's faster and doesn't push/pop quilt
   repository.  Patches are rolled back and applied in a temporary
   working directory.

* gitkdiff rewritten in perl.  It now works with the new git diff
   output format and a bit faster.  Also, this version can show
   multiple commits.  For example, you can do the following.
   $ git-rev-list HEAD ^OLD_HEAD | gitkdiff -c -r

* modified gitk-1.2.

For more information...

http://home-tj.org/mtkdiff

Tarball is available at

http://home-tj.org/mtkdiff/files/mtkdiff-20050801.tar.gz

Thanks.

-- 
tejun
