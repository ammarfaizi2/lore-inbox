Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUDDIYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbUDDIYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 04:24:13 -0400
Received: from A88da.a.pppool.de ([213.6.136.218]:16000 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id S261752AbUDDIYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 04:24:11 -0400
Message-ID: <406FC621.1090507@A88da.a.pppool.de>
Date: Sun, 04 Apr 2004 10:24:01 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Mikhail Ramendik <mr@ramendik.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
References: <fa.g80v5s8.b2ofhi@ifi.uio.no> <fa.ljb660n.d2ofa9@ifi.uio.no>
In-Reply-To: <fa.ljb660n.d2ofa9@ifi.uio.no>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Ramendik wrote:
> Hello,
> 
> Andreas Hartmann wrote:
> 
>> > It turned out that on disk-intensive operation, the "system" CPU usage
>> > skyrockets. With a mere "cp" of a large file to the same direstory
>> > (tested with ext3fs and FAT32 file systems), it is 100% practically all
>> > of the time !
>> But you're right, 2.6.4 is slower than 2.4.25. See the thread "Very poor 
>> performance with 2.6.4" here in the list.
> 
> As recommended there, I have tried 2.6.5-rc3-mm4.
> 
> No change. Still 100% CPU usage; the performance seems teh same.

Yes. But it's curious:
Take a tar-file, e.g. tar the compiled 2.6 kernel directory. Than, untar 
it again - the machine behaves total normaly. And the 2.6-kernel is about 
23% faster than the 2.4-kernel.


> Yours, Mikhail Ramendik
> 
> P.S. Sorry for making all comments into answers to your letter. I just
> don't want to break the thread. 

No problem - it's easier to read with comment directly in the text.


Regards,
Andreas Hartmann
