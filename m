Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUBKONv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUBKONv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:13:51 -0500
Received: from ns.suse.de ([195.135.220.2]:60346 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264433AbUBKONt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:13:49 -0500
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: maze@cela.pl, wdebruij@dds.nl, zstingx@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: printk and long long
References: <20040211135456.B33ED2BD4@etpmod.phys.tue.nl>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Make me look like LINDA RONSTADT again!!
Date: Wed, 11 Feb 2004 15:13:48 +0100
In-Reply-To: <20040211135456.B33ED2BD4@etpmod.phys.tue.nl> (Bart Hartgers's
 message of "Wed, 11 Feb 2004 14:54:56 +0100 (CET)")
Message-ID: <je3c9h66w3.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Hartgers <bart@etpmod.phys.tue.nl> writes:

> On 11 Feb, Maciej Zenczykowski wrote:
>>> how about simply using a shift to output two regular longs, i.e.
>>> 
>>> printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8 >>
>>> sizeof(long) * 8);
>> 
>> I'd venture to guess you'd also have to cast the above to long.
>> 
>> Cheers,
>> MaZe.
>
> And use %lx%lx ?

Rather %lx%0lx.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
