Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbUCOOfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 09:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUCOOfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 09:35:11 -0500
Received: from smtp.ncy.finance-net.fr ([62.161.220.65]:49422 "EHLO
	smtp.ncy.finance-net.fr") by vger.kernel.org with ESMTP
	id S262583AbUCOOfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 09:35:05 -0500
Date: Mon, 15 Mar 2004 15:35:01 +0100
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20040312 Debian/1.4.1-0jds1
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-mm1 and -mm2: include/linux/version.h missing (vanilla ok)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <S262583AbUCOOfF/20040315143505Z+146@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Why is there no include/linux/version.h after having compiled -mm1 and -mm2 ?
Compilation of kernel is fine, but because of this, my nvidia modules won't
compile.

As said in the subject, 2.6.4 vanilla is ok, version.h is here after
compilation.

I use debian woody, and I type

make-kpkg --append-to-version -ff --revision 1 binary-arch
make-kpkg --append-to-version -ff --revision 1 modules_image

to build kernel_image, kernel_headers and nvidia-kernel.

Did I misunderstand something ?
Thank you for any help.

--
Fabian

