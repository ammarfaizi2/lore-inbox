Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUFKGRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUFKGRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 02:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUFKGRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 02:17:22 -0400
Received: from [213.239.201.226] ([213.239.201.226]:25734 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262020AbUFKGRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 02:17:10 -0400
Message-ID: <40C95022.1060104@shadowconnect.com>
Date: Fri, 11 Jun 2004 08:24:34 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/message/i2o/i2o_config.c: user/kernel
 pointer bugs
References: <1086822062.32052.129.camel@dooby.cs.berkeley.edu>
In-Reply-To: <1086822062.32052.129.camel@dooby.cs.berkeley.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Robert T. Johnson wrote:
> Since arg is a user pointer, accessing values like cmd->iop requires an 
> unsafe user pointer dereference.

Yes, you're right...

> QUESTION: Does ioctl_passthru mean arg is a kernel pointer?  If so, then
> disregard this bug report.

No, arg is a user pointer...

> Let me know if you have any questions, and thanks for looking into this.

No, thank you for taking your time, and also making the patch :-)



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
