Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbUDUREy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUDUREy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDUREy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:04:54 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:60327 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263484AbUDUREx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:04:53 -0400
Date: Wed, 21 Apr 2004 19:03:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
Message-ID: <20040421170340.GB24201@wohnheim.fh-wedel.de>
References: <40869267.30408@nortelnetworks.com> <Pine.LNX.4.53.0404211153550.1169@chaos> <4086A077.2000705@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4086A077.2000705@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 April 2004 12:25:27 -0400, Chris Friesen wrote:
> 
> The impression I got was that some equipment was much more vulnerable 
> due to having a) massive windows, and b) using sequential source ports, 
> making it much easier to guess even if you can't tap the line.

Heise.de made it appear, as if the only news was that with tcp
windows, the propability of guessing the right sequence number is not
1:2^32 but something smaller.  They said that 64k packets would be
enough, so guess what the window will be.

Obvious solution would be to use a small window, which would cost
performance.  Different solution would be to use a different window
size for reset, like, say, 1.  Not sure if that would still be
standard, though.

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown
