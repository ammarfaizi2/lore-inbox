Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbTIVB2f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 21:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTIVB2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 21:28:35 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:20374 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S262715AbTIVB2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 21:28:34 -0400
Message-ID: <3F6E5042.40502@comcast.net>
Date: Sun, 21 Sep 2003 18:28:34 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux XFS Mailing List <linux-xfs@oss.sgi.com>
Subject: Re: 2.6.0-test5-mm3 & XFS FS Corruption (or not?)
References: <3F6DC819.8060003@comcast.net> <3F6DE929.4040904@comcast.net> <1064173697.2285.4.camel@laptop.americas.sgi.com> <3F6E49D2.8060901@comcast.net> <20030922011241.GA1043@frodo>
In-Reply-To: <20030922011241.GA1043@frodo>
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

> The fix is below, I'd be interested in whether or not you still have
> problems after applying this.
> 
> thanks.
> 

That appears to have cleared it up. I tried the tests I discovered in my
earlier e-mail of creating bogus lost+found etc... and couldn't get the
filesystem to fail. Mind you, I only ran an rsync over a 2GB filesystem,
but previously the problem was exhibited 100% of the time. I'll bang on
this for a while. Hopefully you don't hear back from me right away :)
Thanks,

-Walt

