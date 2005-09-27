Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVI0Uey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVI0Uey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVI0Uey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:34:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3804 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932418AbVI0Uex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:34:53 -0400
Message-ID: <4339ACDA.3090801@pobox.com>
Date: Tue, 27 Sep 2005 16:34:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <4339440C.6090107@adaptec.com>	 <20050927131959.GA30329@infradead.org>  <43395ED0.6070504@adaptec.com> <1127836380.4814.36.camel@mulgrave> <43399F17.4090004@adaptec.com>
In-Reply-To: <43399F17.4090004@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> Instead of you _waiting_ and thus do nothing, you can
> move out of the way, or listen and accept _technical_ advice.
> 
> This is unfortunate.  History shows us that being
> inflexible to new ideas (or technologies) becomes
> one's undoing.
> 
> I wonder if SCSI Core could be Linux's undoing?  Could this
> and reiser4, and OBDs (yet another new SCSI technology in the
> making), show us how inflexible Linux has become?
> 
> Now its SAS and reiser4.  When OBDs come out full force it
> will be the block layer, then who knows whatelse...
> 
> Is Linux going to be just as obstinate?
> 
> Why has Linux become like this?


Luben,

The fact that your responses are constantly filled with non-technical 
paranoia does not help the inclusion of aic94xx at all.

Maybe you need to write your driver as a block driver, and completely 
skip the SCSI core, if it bothers you so much?  That would get everybody 
else out of the loop, and free you to write the driver as you see fit.

As it stands now, you're making an end run around the SCSI core, rather 
than fixing it up.  SCSI needs to be modified for SAS, not just 
complained about.

	Jeff


