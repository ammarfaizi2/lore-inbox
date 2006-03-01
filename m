Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWCATWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWCATWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWCATWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:22:10 -0500
Received: from rtr.ca ([64.26.128.89]:37076 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751059AbWCATWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:22:09 -0500
Message-ID: <4405F471.8000602@rtr.ca>
Date: Wed, 01 Mar 2006 14:22:25 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: edmudama@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: LibPATA code issues / 2.6.15.4
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
In-Reply-To: <1141239617.23202.5.camel@rousalka.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
>>
> How about the drives that got blacklisted following :
> http://bugzilla.kernel.org/show_bug.cgi?id=5914 ?
> and
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951 ?
> 
> Device Model:     Maxtor 6L300S0
> Firmware Version: BANC1G10
> 
> on Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)

Mmm.. somebody with one of those controllers should check
to see if *any* drives work with FUA, and blacklist the controller
instead of the drives if everything is failing.

Cheers
