Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWJPKwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWJPKwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWJPKwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:52:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:7684 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751494AbWJPKwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:52:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=orxgqrDEi0j+yemlRmG+6zNn55AdsXFACg/pRcdtZgehlgNNmSTRty7Uuf6LIDAuzbXudDN+tzOss2impCk5X4tdpO3IMZqjtab15O7LGwZD47FIbCRYStBM5HgH+I15yzpZo12q5cq+P8sPQ3VWuBVpwsXAliDF3oM2F3XQKh8=
Message-ID: <6bffcb0e0610160352h2bd86f33x72c438c7e8bdf810@mail.gmail.com>
Date: Mon, 16 Oct 2006 12:52:33 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [BUG 2.6.19-rc2-g51018b0a] No rule to make target `/mnt/md0/devel/linux-git/include/linux/version.h
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"make O=/dir" is brooken.

make[4]: *** No rule to make target
`/mnt/md0/devel/linux-git/include/linux/version.h', needed by
`/mnt/md0/devel/linux-git-obj/usr/include/linux/version.h'.  Stop.
make[3]: *** [linux] Error 2
make[2]: *** [headers_install] Error 2
make[1]: *** [vmlinux] Error 2
make: *** [_all] Error 2

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
