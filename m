Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbULFQFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbULFQFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbULFQEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:04:04 -0500
Received: from alpha.lic1.vsi.ru ([80.82.34.34]:51699 "EHLO alpha.lic1.vsi.ru")
	by vger.kernel.org with ESMTP id S261561AbULFQDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:03:02 -0500
Message-ID: <41B482A6.5050904@lic1.vsi.ru>
Date: Mon, 06 Dec 2004 19:02:46 +0300
From: "Igor A. Valcov" <viaprog@lic1.vsi.ru>
Reply-To: viaprog@lic1.vsi.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-ac11 - Badness in futex_wait at kernel/futex.c:542
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In a file /var/log/messages  has detected the following messages:

Badness in futex_wait at kernel/futex.c:542
  [<c012a076>] futex_wait+0x17d/0x187
  [<c0114ee6>] default_wake_function+0x0/0xc
  [<c011b117>] do_wait+0x1b8/0x4b9
  [<c0114ee6>] default_wake_function+0x0/0xc
  [<c010a517>] convert_fxsr_from_user+0x15/0xd8
  [<c012a296>] do_futex+0x35/0x7f
  [<c012a3c0>] sys_futex+0xe0/0xec
  [<c0103e85>] sysenter_past_esp+0x52/0x71

(Gentoo Linux)
glibc-2.3.4.20040808
gcc-3.3.4

-- 
Igor A. Valcov
