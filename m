Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUHKMzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUHKMzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268050AbUHKMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:55:39 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:58451 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268048AbUHKMzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:55:33 -0400
Date: Wed, 11 Aug 2004 08:55:32 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [PATCH] SCSI midlayer power management
In-reply-to: <1092218000.18968.2.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, jgarzik@pobox.com
Message-id: <411A1744.4020100@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <411960C3.5090107@optonline.net>
 <1092218000.18968.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2004-08-11 at 00:56, Nathan Bryant wrote:
>  
>
>>This might help SATA drives, too, but I seem to remember that the SATA 
>>layer doesn't properly emulate the SYNCHRONIZE_CACHE command.
>>    
>>
>
>That was something Mark Lord reported higher level I suspect - which is
>that the scsi path is disabled before the sync cache command is sent so
>the command is always errored before it hits the drive
>  
>
That applies to shutdown, I have no idea whether it also applies to suspend.

Thanks
Nathan
