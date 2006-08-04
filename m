Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbWHDSzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbWHDSzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHDSzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:55:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52190 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751447AbWHDSze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:55:34 -0400
Message-ID: <44D398DA.3010206@sgi.com>
Date: Fri, 04 Aug 2006 20:58:34 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andreas Schwab <schwab@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>	<44BE9E78.3010409@garzik.org> <yq0lkq4vbs3.fsf@jaguar.mkp.net>	<1154702572.23655.226.camel@localhost.localdomain>	<44D35B25.9090004@sgi.com>	<1154706687.23655.234.camel@localhost.localdomain>	<44D36E8B.4040705@sgi.com> <je4pws1ofb.fsf@sykes.suse.de>	<44D370ED.2050605@sgi.com> <jezmekzdb5.fsf@sykes.suse.de>	<44D3753B.1060403@sgi.com> <je3bccmoab.fsf@sykes.suse.de> <44D39658.9080007@sgi.com> <44D39735.8010909@zytor.com>
In-Reply-To: <44D39735.8010909@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Jes Sorensen wrote:
>>
>>> That's how the ABI is defined.
>>
>> That the ABI for long long or the ABI for uint64_t? Given that u64 is a
>> Linux thing, it ought to be ok to do the alignment the right way within
>> the kernel.
>>
> 
> And what will break if you make that switch?

If we are lucky, some binary only modules? :-)

But you're right, it may just have to be documented as one of those
nasty issues to watch out for.

Cheers,
Jes
