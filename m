Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVCBKKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVCBKKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 05:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVCBKKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 05:10:18 -0500
Received: from webmailv3.ispgateway.de ([62.67.200.115]:7322 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S262252AbVCBKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 05:10:09 -0500
Message-ID: <1109758204.422590fca7872@domainfactory-webmail.de>
Date: Wed,  2 Mar 2005 11:10:04 +0100
From: Florian Engelhardt <dot@dot-matrix.de>
To: linux-kernel@vger.kernel.org
Subject: freezes with reiser4 in a raid1 with 2.6.11-rc5-mm1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 213.143.192.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i´m having some trouble here with my testing server.
It uses the 2.6.11-rc5-mm1 kernel, there are three hd´s
in it (all reiser4), hda is the system and boot disk, hdc and hdd are
in a raid 1 (via the kernel´s multiple device driver).
Without the raid, the system works as expected, but when
activating the raid, the system wents unstable and in
some cases it freezes or reboots.

I activated the raid (/dev/md0), then mounted it, and after
that i was starting nfs. I was able to mount the share
on my desktop, creating direcrotys was no problem, but
as soon as i was copying a file to the share, the server
freezed.
Creating files localy (while loged in via ssh) is leading
to the process is staying in state D.
Sometimes, when i start nfsd, the system reboots immediately,
sometimes not.
At the momment, most of the processes are in state D, reboot
does not work, and i am not at home, so i am unable to reboot
the machine manualy.

Every process that trys to do any IO operations on the raid
remains now in state D.

Are there any Problems known with reiser4, linux raid and nfs?

Kind Regards

Florian Engelhardt

PS: I am not on the list, so please CC me

