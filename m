Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVISSuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVISSuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVISSuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:50:15 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:8721 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932567AbVISSuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:50:14 -0400
Message-ID: <432F09E8.6040703@tmr.com>
Date: Mon, 19 Sep 2005 14:56:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.14-rc1 load average calculation broken?
References: <432AE79B.80208@ppp0.net> <Pine.LNX.4.44L0.0509161214490.4972-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0509161214490.4972-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Fri, 16 Sep 2005, Jan Dittmer wrote:


> I recognize the problem.  This experimental patch should fix it:
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=112681273931290&w=2
> 
> Alan Stern
> 
Hum, I wonder if this could be related to my problem of the USB mass 
storage becoming unreachable after a while. I have no problems with 
2.6.13-rc5-git1, but 2.6.14-rc1 and 2.6.13 show the problem. If I see 
the problem again I'll look for the hung processes, but I can't run 
those kernels on the production system any more, if it dies on the 
weekend I have a 260 miles round trip to reboot it.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
