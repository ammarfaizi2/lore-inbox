Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVC2H2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVC2H2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVC2H2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:28:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61119 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262525AbVC2HQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:16:26 -0500
Message-ID: <424900BC.8030109@pobox.com>
Date: Tue, 29 Mar 2005 02:16:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: folkert@vanheusden.com
CC: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>	<20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de>	<424324F1.8040707@pobox.com> <20050327171934.GB18506@muc.de> <20050327185500.GP943@vanheusden.com>
In-Reply-To: <20050327185500.GP943@vanheusden.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folkert@vanheusden.com wrote:
>>>pool.  The consensus was that the FIPS testing should be moved to userspace.
>>
>>Consensus from whom? And who says the FIPS testing is useful anyways?
>>I think you just need to trust the random generator, it is like
>>you need to trust any other piece of hardware in your machine. Or do you 
>>check regularly if you mov instruction still works? @)
> 
> 
> For joe-user imho it's better to do a check from a cronjob once a day. But for

That would not catch the hardware failures seen in the field, in the past.

	Jeff



