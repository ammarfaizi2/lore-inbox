Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWIJIIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWIJIIp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 04:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWIJIIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 04:08:45 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:57181 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750781AbWIJIIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 04:08:44 -0400
Message-ID: <4503C807.5040403@tls.msk.ru>
Date: Sun, 10 Sep 2006 12:08:39 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: "jens m. noedler" <noedler@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rc6] [resend] Documentation/ABI: devfs is not obsolete,
 but removed!
References: <4502F7A9.70200@web.de> <45030245.9080005@tls.msk.ru> <20060909220230.GA19539@suse.de>
In-Reply-To: <20060909220230.GA19539@suse.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Sep 09, 2006 at 10:04:53PM +0400, Michael Tokarev wrote:
>> jens m. noedler wrote:
>>> Hi everybody, Greg, Linus,
>>>
>>> This little patch just moves the devfs entry from ABI/obsolete to
>>> ABI/removed and adds the comment, that devfs was removed in 2.6.18.
>>>
>> []
>>> +	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
>>> +	along with the the assorted devfs function calls throughout the
>>> +	kernel tree.
>> So, will the files be removed at some point, or has them been removed
>> already? :)
> 
> They are already removed.

I know they're gone. I was just pointing out that the patch is wrong,
as it claims the files *will* be removed.

/mjt
