Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUFBNXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUFBNXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUFBNXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:23:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60393 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262744AbUFBNXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:23:36 -0400
Message-ID: <40BDD4C9.5070602@pobox.com>
Date: Wed, 02 Jun 2004 09:23:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <40BD1211.9030302@pobox.com> <40BD95EB.40506@shadowconnect.com>
In-Reply-To: <40BD95EB.40506@shadowconnect.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Lidel wrote:
> Jeff Garzik wrote:
>> My preferred approach would be:  consider that the hardware does not 
>> need the entire 0x8000000-byte area mapped.  Plain and simple.
>> This is a "don't do that" situation, and that renders the other 
>> questions moot :)  You should only be mapping what you need to map.
> 
> 
> Okay, i'll let try it out with only 64MB.


Why do you need 64MB, even?  :)

	Jeff


