Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263624AbUEPP04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUEPP04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 11:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUEPP04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 11:26:56 -0400
Received: from APastourelles-108-2-1-3.w80-14.abo.wanadoo.fr ([80.14.139.3]:3848
	"EHLO samwise.two-towers.net") by vger.kernel.org with ESMTP
	id S263624AbUEPP0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 11:26:55 -0400
Message-ID: <40A78834.1030605@two-towers.net>
Date: Sun, 16 May 2004 17:26:44 +0200
From: Philip Dodd <phil.lists@two-towers.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Daniele Bernardini <db@sqbc.com>, linux-kernel@vger.kernel.org
Subject: Re: dma ripping
References: <1084548566.12022.57.camel@linux.site> <20040515101415.GA24600@suse.de> <1084610731.4666.8.camel@linux.site> <20040515145800.GE24600@suse.de> <1084629809.4612.51.camel@linux.site> <20040515211901.GG24600@suse.de>
In-Reply-To: <20040515211901.GG24600@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
8<
> You are not being stupid, I think we have a leak in there some where.
> PIO should work just fine. Slower than DMA of course, but it should work
> perfectly of course.

Hi All,

Just a quick "me too" here - though symptoms don't appear to be 
identical.  Running 2.6.6 on Debian Sid and using nvidia binary modules. 
  My system doesn't hang, but when I get the log message "cdrom: 
dropping to single frame dma" ripping stops working.  It still rips but 
I get silence - it will rip the track OK, as in read through the correct 
track length, but I get silence on the resulting wav file.

Please let me know if I can let you have any information about this problem.

Kind regards,

Phil
