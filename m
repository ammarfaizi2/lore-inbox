Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUJTA6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUJTA6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJTA5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:57:05 -0400
Received: from mx15.sac.fedex.com ([199.81.195.17]:5896 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S268053AbUJTAYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:24:40 -0400
Date: Wed, 20 Oct 2004 08:21:10 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
Subject: Re: [ANNOUNCE] iproute2 2.6.9-041019
In-Reply-To: <41758014.4080502@osdl.org>
Message-ID: <Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>
References: <41758014.4080502@osdl.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/20/2004
 08:24:34 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/20/2004
 08:24:37 AM,
	Serialize complete at 10/20/2004 08:24:37 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Oct 2004, Stephen Hemminger wrote:

> Now that 2.6.9 is final. Here is an update of the iproute2 utilities that


can't compile Got the following error. Linux is 2.6.9. Gcc is 2.95.3.


make[1]: Entering directory `/usr/src/net/iproute2-2.6.9/misc'
gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -g -I../include 
-DRESOLVE_HOSTNAMES   -c -o ss.o ss.c
In file included from /usr/include/asm/byteorder.h:57,
                  from ss.c:36:
/usr/include/linux/byteorder/little_endian.h:43: parse error before 
`__cpu_to_le64p'
/usr/include/linux/byteorder/little_endian.h: In function 
`__cpu_to_le64p':
/usr/include/linux/byteorder/little_endian.h:45: `__le64' undeclared 
(first use in this function)
/usr/include/linux/byteorder/little_endian.h:45: (Each undeclared 
identifier is reported only once
...

a lot of these errors.

These errors went away if linux-2.4.28pre4 is used to compile.


Thanks,
Jeff.

