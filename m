Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTJQMi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJQMi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:38:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61852 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263451AbTJQMi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:38:57 -0400
Message-ID: <3F8FE2D1.6090400@pobox.com>
Date: Fri, 17 Oct 2003 08:38:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3,6,7] IDE 'enhanced mode' problems
References: <1066388412.1585.8.camel@paragon.slim>
In-Reply-To: <1066388412.1585.8.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> Hi,
> 
> I have various systems running 2.6.0-test kernels without problems so I
> thought lets try 2.6.0-test7 on my main system again...I had run test3
> without problems on this system but now all of a sudden it could not
> boot 2.6.0-test3/6/7 normally. It would never pass through init
> completely. It just stalled.
> 
> The only thing I changed since the last time I ran 2.6.0 successfully
> was that I removed the SATA drive (I am running this on a Asus P4C800).
> In the BIOS the IDE settings where still set to 'Enhanced mode'. The 2.4
> kernel series doesn't seem to have a problem with it. I can't boot 2.6.0
> with this setting on.
> 
> After changing the mode back to 'Compatible' I can run 2.6.0 properly
> again.
> 
> Is this a bug in the IDE ICH5 code?


Are you running libata?

	Jeff



