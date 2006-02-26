Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWBZQXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWBZQXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWBZQXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:23:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:38889 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751335AbWBZQXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:23:10 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4401D589.6080204@s5r6.in-berlin.de>
Date: Sun, 26 Feb 2006 17:21:29 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by	sd_read_cache_type
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de>	 <20060225021009.GV3883@sorel.sous-sol.org>	 <4400E34B.1000400@s5r6.in-berlin.de>	 <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org>	 <1140930888.3279.4.camel@mulgrave.il.steeleye.com>	 <20060226053138.GM27946@ftp.linux.org.uk> <1140964451.3337.5.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1140964451.3337.5.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.731) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
...
> how about this for the actual patch (for 2.6.16) ... I put two
> more tidy ups into it ...
...
> +#define SD_BUF_SIZE		512

Thanks.
Believe it or not, I was actually about to follow up with something like 
this. :-)
-- 
Stefan Richter
-=====-=-==- --=- ==-=-
http://arcgraph.de/sr/
