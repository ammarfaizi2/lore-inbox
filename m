Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTDIBFN (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbTDIBFN (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:05:13 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:33756 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S261921AbTDIBFM (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 21:05:12 -0400
Message-ID: <3E9376FA.7070906@kegel.com>
Date: Tue, 08 Apr 2003 18:27:22 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fsync() on unix domain sockets?
References: <3E934DB7.1000503@kegel.com> <Pine.LNX.4.53.0304082101020.26881@chaos>
In-Reply-To: <Pine.LNX.4.53.0304082101020.26881@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
 > You will never find
> any unflushed buffers in Unix Domain sockets because you need
> an active reader before the write will succeed. The writer will
> block until the reader has all the data.

OK, then, at least I had a nice read through the af_unix.c code.
I guess I'll write a little test program to verify the problem
I thought I had doesn't exist.

Thanks,
Dan


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

