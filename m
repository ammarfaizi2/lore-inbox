Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTFZQaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 12:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTFZQaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 12:30:09 -0400
Received: from routeree.utt.ro ([193.226.8.102]:62880 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S262030AbTFZQaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 12:30:04 -0400
Message-ID: <9849.194.138.39.55.1056646128.squirrel@webmail.etc.utt.ro>
Date: Thu, 26 Jun 2003 19:48:48 +0300 (EEST)
Subject: Re: [Jfs-discussion] [PATCH] Re: Jfs problems
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <shaggy@austin.ibm.com>
In-Reply-To: <200306231630.51359.shaggy@austin.ibm.com>
References: <35119.194.138.39.55.1056364461.squirrel@webmail.etc.utt.ro>
        <200306231533.49595.shaggy@austin.ibm.com>
        <200306231630.51359.shaggy@austin.ibm.com>
X-Priority: 3
Importance: Normal
Cc: <jfs-discussion@www-124.southbury.usf.ibm.com>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Kleikamp said:
> On Monday 23 June 2003 15:33, Dave Kleikamp wrote:
>>
>> I think I found the problem.  The patch below should fix it.  I will
>> try to reproduce the problem and verify that this patch works.
>
> I wasn't able to reproduce the trap (which depends on the contents of
> uninitialized memory) but I was able to verify that it fixes a problem
> where changes to a directory got lost.  I'm convinced the patch is
> good.
>

I applied it. It seems to work. Didn't have much time to test it.
I did a quick test with a dd=if/dev/zero of=file ; rm file
and it seems to work

Thanks


> --
> David Kleikamp
> IBM Linux Technology Center
>
> -

Calin

-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


