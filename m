Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTJMSuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTJMSuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 14:50:12 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:4080 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S261903AbTJMSuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 14:50:09 -0400
Message-ID: <3F8AF389.80600@superonline.com>
Date: Mon, 13 Oct 2003 21:48:41 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7-pac1
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I listen to the evil whispers and say "m" to CONFIG_IP_SCTP,
then my build logs are spammed by messages like the following:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-pre7-pac1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3   -nostdinc -iwithprefix include -DKBUILD_BASENAME=md  -DEXPORT_SYMTAB -c md.c
In file included from /usr/src/linux-2.4.23-pre7-pac1/include/net/sctp/ulpevent.h:51,
		from /usr/src/linux-2.4.23-pre7-pac1/include/net/sctp/structs.h:93,
		from /usr/src/linux-2.4.23-pre7-pac1/include/net/sock.h:53,
		from /usr/src/linux-2.4.23-pre7-pac1/include/net/ip.h:39,
		from /usr/src/linux-2.4.23-pre7-pac1/include/net/checksum.h:31,
		from /usr/src/linux-2.4.23-pre7-pac1/include/linux/raid/md.h:35,
		from md.c:33:
/usr/src/linux-2.4.23-pre7-pac1/include/net/sctp/compat.h:74: warning: static declaration for `generic_fls' follows non-static

Since there are no changes to stcp code in -pac, this should also
be a problem for mainline.

Regards,
Özkan Sezer

