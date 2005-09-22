Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVIVOUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVIVOUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVIVOUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:20:30 -0400
Received: from magic.adaptec.com ([216.52.22.17]:60830 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030367AbVIVOU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:20:29 -0400
Message-ID: <4332BDA3.5050705@adaptec.com>
Date: Thu, 22 Sep 2005 10:20:19 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>	 <20050922061849.GJ7929@suse.de>	 <1127398679.18840.84.camel@localhost.localdomain>	 <20050922135607.GK4262@suse.de> <1127399409.18840.95.camel@localhost.localdomain>
In-Reply-To: <1127399409.18840.95.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 14:20:27.0278 (UTC) FILETIME=[C771F2E0:01C5BF80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/05 10:30, Alan Cox wrote:
> On Iau, 2005-09-22 at 15:56 +0200, Jens Axboe wrote:
> 
>>It's a shame for the people not using distros, since they need to first
>>experience the suspend failure, then google around for a solution, find
>>the patch, etc. That is a shame, since it could have worked out of the
>>box since 2.6.12 at least.
> 
> 
> Its a symptom of general problems in this area. To get a sane kernel you
> have to not only pick a distro kernel right now but then add several
> other patches only found in other distributions.
> 
> SCSI suspend should not be blocking SATA suspend. If SCSI isn't with the
> program yet then SCSI should just not support suspend while allowing
> SATA to do so.

I agree with Alan, Mark and Jens -- indeded, one should do
what makes sense.

	Luben



