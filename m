Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbRL1B3x>; Thu, 27 Dec 2001 20:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285632AbRL1B3n>; Thu, 27 Dec 2001 20:29:43 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:21764 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S285618AbRL1B30>;
	Thu, 27 Dec 2001 20:29:26 -0500
Mailbox-Line: From tmh@nothing-on.tv  Fri Dec 28 01:29:20 2001
Mailbox-Line: From tmh@nothing-on.tv  Fri Dec 28 01:29:17 2001
From: Tony Hoyle <tmh@nothing-on.tv>
Subject: nfs + ipv6 hanging???
Date: Fri, 28 Dec 2001 01:29:17 +0000
Organization: cvsnt.org news server
Message-ID: <3C2BCAED.2030908@nothing-on.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sisko.my.home 1009502957 2357 192.168.100.2 (28 Dec 2001 01:29:17 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011224
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.17, gcc-2.95.4, mount 2.11n

nfs clients seem to hang when ipv6 is on the machine.  No idea why...
the mount process gets stuck in 'D' state and the only way out is to
reboot.

If I remove ipv6 from the box & perform exactly the same operations then 
it works perfectly.  The mount is definately using the ipv4 address (I 
don't think the portmapper/nfsd is ipv6 enabled anyway).

Tony

