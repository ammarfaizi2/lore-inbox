Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUBVUbI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUBVUbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:31:07 -0500
Received: from fep04.swip.net ([130.244.199.132]:503 "EHLO fep04-svc.swip.net")
	by vger.kernel.org with ESMTP id S261744AbUBVUbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:31:05 -0500
Message-ID: <403911B3.10601@laposte.net>
Date: Sun, 22 Feb 2004 21:31:47 +0100
From: mjl <malet.jean-luc@laposte.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040215
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [linux 2.6.3] [gcc 3.3.3] compile errors
X-Priority: 1 (highest)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello please cc me since I'm not a member
all my builds fails with this error

In file included from ../include/swab.h:20,
                 from ../include/misc.h:12,
                 from io.c:21:
/usr/include/linux/byteorder/swab.h:133: error: syntax error before "__u16"
/usr/include/linux/byteorder/swab.h:146: error: syntax error before "__u32"
make[1]: *** [io.o] Error 1
make[1]: Leaving directory `/usr/src/sorcery/reiserfsprogs-3.6.13/lib'
make: *** [all-recursive] Error 1


I looked into the source and  the line is


static __inline__ __attribute_const__ __u16 __fswab16(__u16 x)
{


which don't looks bad ......
thanks
