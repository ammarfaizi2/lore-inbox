Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVCaWvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVCaWvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVCaWvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:51:37 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:20810 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262042AbVCaWve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:51:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qEFCajbeK/hg4N7ffG3oOtB6/yULT2Z+jqEM9bVkUFHMup+ivGVT0sa3eCAOkiex/txHwabWsIBqTUN4nDlxt03Y9pug/vCkSBxy8mj4zdVv9hDNdb3h7WoYTnp7Q1F/XxgTZOk4zQDEIAMJBAhBXw/9nJDbDH1vxlSy3tPd5vc=
Message-ID: <424C7EF0.5000206@gmail.com>
Date: Fri, 01 Apr 2005 07:51:28 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Lash <jkl@sarvega.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       mage@adamant.ua
Subject: Re: sata_sil Mod15Write quirk workaround patch for vanilla kernel
 avaialble.
References: <424C10C3.9080102@gmail.com> <20050331111044.4a3672cd@homer.sarvega.com>
In-Reply-To: <20050331111044.4a3672cd@homer.sarvega.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello, John.

John Lash wrote:
> On Fri, 01 Apr 2005 00:01:23 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
> 
>> Hello, guys.
>>
>> I  generated m16w workaround patch for 2.6.11.6 (by just removing two
>>lines :-) and set up a page regarding m15w quirk and the workaournd.
>>I'm planning on updating m15w patch against the vanilla tree until it
>>gets into the mainline so that impatient users can try out and it gets
>>more testing.
>>
>> http://home-tj.org/m15w
>>
>> Thanks.
>>
>>-- 
>>tejun
>>
> 
> 
> Tejun,
> 
> I applied the patch to a clean 2.6.11.6 kernel and got an unresolved
> symbol error for "ATA_TFLAG_LBA". I tried changing that to "ATA_TFLAG_LBA48" and
> it compiles and runs.
> 
> So far, no problems. Thanks a lot for the patch.
> 
> --john

  I'm sorry.  I uploaded the original patch against libata-dev-2.6 tree. 
  The two BUG_ON() lines should just be removed.  I've uploaded fixed 
patch.  Thanks for pointing out.

-- 
tejun

