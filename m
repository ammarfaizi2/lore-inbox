Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVCVIRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVCVIRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVCVIRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:17:23 -0500
Received: from wasp.net.au ([203.190.192.17]:53632 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S262374AbVCVIRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:17:20 -0500
Message-ID: <423FD484.2080604@wasp.net.au>
Date: Tue, 22 Mar 2005 12:17:08 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jniehof@bu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: LBD/filesystems over 2TB: is it safe?
References: <37550.128.197.73.126.1111445738.squirrel@128.197.73.126>
In-Reply-To: <37550.128.197.73.126.1111445738.squirrel@128.197.73.126>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jniehof@bu.edu wrote:

> Running x86-32 using kernel 2.6.8 (from Debian sarge), although can always
> roll my own if necessary. Preferred filesystem would be ext3, and I
> anticipate no need to grow beyond the initial 2.5TB.

I'm running 2.1TB and 3TB filesystems on ext3 here. It's probably not fast or optimal, however it's 
been solidly reliable. The 2.1 has been running since May 2004 with a reasonable workload. The 3TB 
is only 4 weeks old, but has been beaten pretty hard during burn-in testing.

x86-32 with 2.6.[5 6 9 10] on the 2.1 and 2.6.11-bk's on the 3.

Both filesystems have been filled to capacity during testing and real use. I unmount them and e2fsck 
-f them weekly just for a laugh also. Never a hitch.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
