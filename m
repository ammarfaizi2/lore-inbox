Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUJHD71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUJHD71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUJHD7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:59:18 -0400
Received: from relay.pair.com ([209.68.1.20]:21522 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267620AbUJHD5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 23:57:16 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <41661013.9090700@cybsft.com>
Date: Thu, 07 Oct 2004 22:57:07 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
References: <1097178019.24355.39.camel@localhost> <1097188963l.6408l.2l@werewolf.able.es>
In-Reply-To: <1097188963l.6408l.2l@werewolf.able.es>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> 
> On 2004.10.07, Dave Hansen wrote:
> 
>> I just booted 2.6.9-rc3-mm3 and got the good ol'
>> VFS: Cannot open root device "sda2" or unknown-block(0,0)
>> Please append a correct "root=" boot option
>> Kernel panic - not syncing: VFS: Unable to mount root fs on
>> unknown-block(0,0)
>>
>> backing out bk-scsi.patch seems to fix it.  I believe this worked in
>> 2.6.9-rc3-mm2.
>>
> 
> Mine works:
> 
> 03:0c.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
> 
> werewolf:~> uname -a
> Linux werewolf.able.es 2.6.9-rc3-mm3 #1 SMP...

Mine doesn't without backing out those patches :) See my other post 
about this.

04:05.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
04:05.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

kr
