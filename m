Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWBLESW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWBLESW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 23:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWBLESW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 23:18:22 -0500
Received: from rtr.ca ([64.26.128.89]:58318 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932172AbWBLESW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 23:18:22 -0500
Message-ID: <43EEB6FE.7000701@rtr.ca>
Date: Sat, 11 Feb 2006 23:18:06 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
References: <20060208062007.GA7936@kroah.com> <43EE9EC0.2030403@rtr.ca> <20060212041522.GA29935@suse.de>
In-Reply-To: <20060212041522.GA29935@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Feb 11, 2006 at 09:34:40PM -0500, Mark Lord wrote:
>> Greg KH wrote:
>>> So, here's a patch that implements EXPORT_SYMBOL_GPL_FUTURE().  It
>>> basically says that some time in the future, this symbol is going to
>>> change and not be allowed to be called from non-GPL licensed kernel
>>> modules.
>> The wording and intent here are incorrect.
>>
>> All kernel modules are already *GPL licensed*,
>> whether the authors think so or not.
>>
>> So this patch (if it goes through), should be reworded
>> so as not to muddy those waters (as the above excerpt does).
> 
> Care to provide some text that you feel will be better?

Just something simple, like this rewording of your original post:

 >>> So, here's a patch that implements EXPORT_SYMBOL_GPL_FUTURE().  It
 >>> basically says that some time in the future, this symbol is going to
 >>> change and not be allowed to be called from
...kernel modules that don't include MODULE_LICENSE("GPL") in the source.

Cheers
