Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUDJFcL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 01:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUDJFcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 01:32:11 -0400
Received: from memebeam.org ([212.13.199.71]:25094 "EHLO jvb.vm.bytemark.co.uk")
	by vger.kernel.org with ESMTP id S261928AbUDJFcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 01:32:08 -0400
Message-ID: <407786C6.7030706@neggie.net>
Date: Sat, 10 Apr 2004 01:31:50 -0400
From: John Belmonte <john@neggie.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs	namespace
References: <1081453741.3398.77.camel@patsy.fc.hp.com>	 <1081549317.2694.25.camel@patsy.fc.hp.com>  <4077535D.6020403@neggie.net> <1081566768.2562.8.camel@wilson.home.net>
In-Reply-To: <1081566768.2562.8.camel@wilson.home.net>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson wrote:
> On Fri, 2004-04-09 at 19:52, John Belmonte wrote:
> 
>>The limitation of this interface is that it's not able to call an ACPI 
>>method with some arguments and get the return value, correct?
> 
>    Yes, that's unfortunately a limitation.  Most of the standard
> interfaces either take no parameters or have no return value, so they
> fit nicely into this framework.  I'm open to suggestions on how to work
> around this.  We could make the store function save off the method
> parameters, then the show function would call the method with the saved
> parameters and return the results.  Obviously there are some userspace
> ordering issues that could make this complicated, but it's easy to code
> on the kernel side.  Other ideas?  Thanks,

You may want to look at the acpi-devel thread "[rfc] generic testing 
ACPI module", where this issue was discussed 
(http://sourceforge.net/mailarchive/message.php?msg_id=7455349).

-John


-- 
http:// if  ile.org/
