Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWG2ORd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWG2ORd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 10:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWG2ORd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 10:17:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:32714 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750790AbWG2ORc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 10:17:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=exyNPVGOttly0h6BCHSwP09iqvmyNVYitt2x5g/DaPANmB+LRyOAxGLVCqBY9+0Fob2kwcZxuopKkJ8yEaxhH1Dwjz2ot4rzhClI1DEXNCyu/UJ6yVExGmTcQjbf+dazZg0KQg0+7dAxYioZNi3Azhf8SSv13kphE2GFuKseang=
Date: Sat, 29 Jul 2006 16:16:32 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
Message-ID: <20060729141632.GC28712@leiferikson.dystopia.lan>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <44CA5043.2090603@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CA5043.2090603@xs4all.nl>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 28, 2006 at 07:58:27PM +0200, Udo van den Heuvel wrote:
> Jul 28 18:21:54 epia kernel: Call Trace:
> Jul 28 18:21:54 epia kernel: Code: 20 70 6f 72 74 20 35 38 31 31 33 20
> 73 73 68 32 0a 4a 75 6c 20 32 33 20 31 36 3a 35 35 3a 31 31 20 65 70 69
> 61 20 73 73 68 64 5b <31> 32 36 39 32 5d 3a 20 46 61 69 6c 65 64 20 70
> 61 73 73 77 6f
> Jul 28 18:21:54 epia kernel: EIP: [pg0+336277895/1069671424] 0xd4493187
> SS:ESP 0068:dd5d9f3c
> Jul 28 18:21:54 epia kernel: EIP: [<d4493187>] 0xd4493187 SS:ESP
> 0068:dd5d9f3c

There are no symbol names... Enable CONFIG_KALLSYMS (can be
found in General Setup -> Configure standard kernel features)

Hannes

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
