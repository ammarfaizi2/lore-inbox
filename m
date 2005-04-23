Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVDWOac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVDWOac (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 10:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVDWOac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 10:30:32 -0400
Received: from mail.portrix.net ([212.202.157.208]:20102 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261597AbVDWOa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 10:30:26 -0400
Message-ID: <426A5BFC.1020507@ppp0.net>
Date: Sat, 23 Apr 2005 16:30:20 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Git-commits mailing list feed.
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>	 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>	 <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain>
In-Reply-To: <1114266083.3419.40.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Sat, 2005-04-23 at 14:58 +0200, Jan Dittmer wrote:
> 
>>I didn't found above mentioned post, so I hacked up a cruel script
>>myself. It relies on ketchup (www.selenic.com/ketchup)
>>to retrieve the current base version. Also it requires git's
>>`checkout-cache --prefix=` to work properly.
> 
> 
> Thanks... but it seems a little excessive. I was thinking of something
> much simpler; along the lines of...
> 
> #!/bin/sh
> 
> STAGE=/staging/dwmw2/git
> 
> cd /home/dwmw2/git/snapshot-2.6
> 
> git pull || exit 1
> 
> LASTRELEASE=`ls -rt .git/tags | grep -v git | grep -v MailDone | tail -1`

My .git/tags is empty. At least 2.6.12-rc3 is not tagged so I wasn't sure
how to extract the latest release from the git tree.
ketchup was the most comfortable way.

-- 
Jan
