Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTIIAU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTIIAU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:20:28 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:61661 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S263793AbTIIAUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:20:25 -0400
Message-ID: <3F5D1CC7.1050401@cox.net>
Date: Mon, 08 Sep 2003 17:20:23 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: jdow <jdow@earthlink.net>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: problem with "Gadget filesystem" config prompt (bk10)
References: <Pine.LNX.4.44.0309081137260.15517-100000@localhost.localdomain> <20030908221102.GA2953@kroah.com> <043301c37659$d0074490$2eedfea9@kittycat> <20030908230224.GA3047@kroah.com>
In-Reply-To: <20030908230224.GA3047@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Mon, Sep 08, 2003 at 03:37:40PM -0700, jdow wrote:
> 
>>
>>Perhaps the incorrect prompt could be fixed?
> 
> 
> Patches are always welcome.
> 

I don't believe there's a patch necessary here. The options shown at 
the prompt are computed by the conf program based on the current 
configuration. If he had a parent option set to 'm' that keeps this 
item from being set to 'y', then 'y' won't be shown as an available 
option. Changing the parent option will result in the child option 
having the 'y' choice available again.

