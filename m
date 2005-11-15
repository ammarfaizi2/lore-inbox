Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVKOQ1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVKOQ1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVKOQ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:27:45 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:12996 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S964855AbVKOQ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:27:44 -0500
Message-ID: <437A0C7B.1060309@shadowconnect.com>
Date: Tue, 15 Nov 2005 17:27:39 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] I2O: Bugfixes
References: <4379AAED.3020307@shadowconnect.com> <20051115150643.GB4516@redhat.com>
In-Reply-To: <20051115150643.GB4516@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dave Jones wrote:
> On Tue, Nov 15, 2005 at 10:31:25AM +0100, Markus Lidel wrote:
>  > Changes:
>  > --------
>  > - Removed some kmalloc's with __GFP_ZERO and replace it with memset()
>  >   because it didn't work properly.
> 
> kzalloc() perhaps ?

Ahhh, yep, that was what i'm looking for :-D In the next update i'll 
replace it with the proper function...

Thanks for the hint!



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
