Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUBKNy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 08:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUBKNy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 08:54:58 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:60468 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP id S264366AbUBKNy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 08:54:57 -0500
Date: Wed, 11 Feb 2004 14:54:56 +0100 (CET)
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
Reply-To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Subject: Re: printk and long long 
To: maze@cela.pl
Cc: wdebruij@dds.nl, zstingx@hotmail.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Message-Id: <20040211135456.B33ED2BD4@etpmod.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Feb, Maciej Zenczykowski wrote:
>> how about simply using a shift to output two regular longs, i.e.
>> 
>> printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8 >>
>> sizeof(long) * 8);
> 
> I'd venture to guess you'd also have to cast the above to long.
> 
> Cheers,
> MaZe.

And use %lx%lx ?

> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
