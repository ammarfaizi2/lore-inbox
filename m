Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUDTXb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUDTXb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUDTXb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:31:57 -0400
Received: from mrout1.yahoo.com ([216.145.54.171]:18449 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S264497AbUDTXbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:31:37 -0400
Message-ID: <4085B2B9.6010007@bigfoot.com>
Date: Tue, 20 Apr 2004 16:31:05 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
References: <40853060.2060508@bigfoot.com> <200404202326.24409.kim@holviala.com>
In-Reply-To: <200404202326.24409.kim@holviala.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala wrote:
> On Tuesday 20 April 2004 17:14, Erik Steffl wrote:
> 
> 
>>   it looks that after update to 2.6.5 kernel (debian source package but
>>I guess it would be the same with stock 2.6.5) the mouse wheel and side
>>button on Logitech Cordless MouseMan Wheel mouse do not work.
> 
> 
> Try my patch for 2.6.5: http://lkml.org/lkml/2004/4/20/10

   which part is patch? click on view this diff only and copy&paste that 
and use it as a patch?

   thanks,

	erik

> Build psmouse into a module (for easier testing) and insert it with the proto 
> parameter. I'd say "modprobe psmouse proto=exps" works for you, but you might 
> want to try imps and ps2pp too. The reason I wrote the patch in the first 
> place was that a lot of PS/2 Logitech mice refused to work (and yes, exps 
> works for me and others)....
> 
> 
> 
> Kim
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


