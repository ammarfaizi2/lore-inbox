Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267171AbUHOWIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267171AbUHOWIC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUHOWIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:08:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5003 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267171AbUHOWH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:07:58 -0400
Message-ID: <411FDEA9.2010802@pobox.com>
Date: Sun, 15 Aug 2004 18:07:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <1092603321.18410.5.camel@localhost.localdomain>
In-Reply-To: <1092603321.18410.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2004-08-15 at 22:36, Jeff Garzik wrote:
> 
>>	$ hdparm -c1 /dev/hda
>>		becomes
>>	$ blktool /dev/hda pio-data 32-bit
> 
> 
> So you've replaced hdparm's weird but unixish command line with an
> even more demented non linuxish one that doesn't handle regexps for
> drive names ?
> 
> Whatever happened to
> 
> 	blktool /dev/hda --pio-data=32


Yep, it's more like ethtool(8) or cvs(1) in its syntax.  There is big 
difference in usability (for me anyway) between "command [options]..." 
and an unordered list of --args.  Especially as the list of commands 
grows longer.  It provides more structure.

Each command can have options, --foo-bar=baz if you like, I suppose.

	Jeff


