Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270720AbTGUVEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270722AbTGUVEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:04:33 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:43280 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S270720AbTGUVEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:04:31 -0400
Date: Mon, 21 Jul 2003 17:19:30 -0400 (EDT)
From: root <root@oddball.prodigy.com>
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1-wli-1 compile fail
Message-ID: <Pine.LNX.4.44.0307211717270.23650-101000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1653083592-1058822370=:23650"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1653083592-1058822370=:23650
Content-Type: TEXT/PLAIN; charset=US-ASCII

Error:

fs/namei.c: In function `path_lookup':
fs/namei.c:868: parse error before `*'
fs/namei.c:873: `dirs' undeclared (first use in this function)
fs/namei.c:873: (Each undeclared identifier is reported only once
fs/namei.c:873: for each function it appears in.)
fs/namei.c:873: `fs' undeclared (first use in this function)
fs/namei.c:890: `task' undeclared (first use in this function)
make[1]: *** [fs/namei.o] Error 1
make: *** [fs] Error 2

gzipped and comment-stripped config attached. And I had such hopes...

--8323328-1653083592-1058822370=:23650
Content-Type: APPLICATION/x-gzip; name="config.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0307211719300.23650@oddball.prodigy.com>
Content-Description: 
Content-Disposition: attachment; filename="config.gz"

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
--8323328-1653083592-1058822370=:23650--
