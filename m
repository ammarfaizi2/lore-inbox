Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUBKXLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 18:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266267AbUBKXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 18:11:17 -0500
Received: from ti200710a080-3502.bb.online.no ([80.213.45.174]:8689 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S266263AbUBKXLQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 18:11:16 -0500
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk and long long
References: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl>
	<c0e0gr$mcv$1@terminus.zytor.com> <yw1xvfmdwe4s.fsf@kth.se>
	<je8yj9cl27.fsf@sykes.suse.de>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Feb 2004 00:11:09 +0100
In-Reply-To: <je8yj9cl27.fsf@sykes.suse.de> (Andreas Schwab's message of
 "Wed, 11 Feb 2004 23:23:28 +0100")
Message-ID: <yw1xn07pw6sy.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> mru@kth.se (Måns Rullgård) writes:
>
>> What is the proper way to deal with printing an int64_t when int64_t
>> can be either long or long long depending on machine?
>
> PRId64 from <inttypes.h> (replace d with the desired format character).
> This is for user space, not sure whether that is acceptable for kernel
> code (<intttypes.h> is not one of the required headers for freestanding
> implementations).

That should work for userspace.  What standard specifies those?
What about kernel sources?

-- 
Måns Rullgård
mru@kth.se
