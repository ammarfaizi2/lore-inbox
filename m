Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRDSPKN>; Thu, 19 Apr 2001 11:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRDSPKD>; Thu, 19 Apr 2001 11:10:03 -0400
Received: from samar.sasken.com ([164.164.56.2]:39396 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S129084AbRDSPJw>;
	Thu, 19 Apr 2001 11:09:52 -0400
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-b.sasi.com
From: Praveen Rajendran <rp@sasken.com>
Subject: linux timer performance ?
Date: Fri, 20 Apr 2001 02:10:39 +0530
Organization: Sasken Communication Technologies Limited
Message-ID: <3ADF4D47.7B9B5EFD@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: ncc-c.sasi.com 987692928 5814 10.0.35.252 (19 Apr 2001 15:08:48 GMT)
X-Complaints-To: usenet@sasi.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
Xref: ncc-b.sasi.com maillist.linux-kernel:146535
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I am working on a kernel module which requires the addition of a large
number of kernel timers  to expire statistical values ( including time
) maintained in a table.

One alternative would be to use a single timer and traverse the entire
table and use the existing system time to expire the values ( comparing
it with the time already stored in the table )when the timer expires .

Following the method I describe first I would have to add a large number
of timers ( around 2000) ... would this cause any significant
performance drop  ? which method should I use ?

thanks in advance

Praveen




