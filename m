Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRAXHpC>; Wed, 24 Jan 2001 02:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAXHox>; Wed, 24 Jan 2001 02:44:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18188 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129375AbRAXHoj>; Wed, 24 Jan 2001 02:44:39 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: stripping symbols from modules
Date: 23 Jan 2001 23:42:54 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <94m11u$3re$1@cesium.transmeta.com>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188095D@xsj02.sjs.agilent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <FEEBE78C8360D411ACFD00D0B747797188095D@xsj02.sjs.agilent.com>
By author:    hiren_mehta@agilent.com
In newsgroup: linux.dev.kernel
>
> That is what I was guessing. But insmod does not need all symbols
> present in the .o. 
> 
> I need to do this because when I release the driver to the customer,
> I don't want them to be aware of some of the symbols. I understand
> that this is against the open source policy. But that's how it is
> and it is beyond my control. Is there any way to export only
> selected symbols as required by insmod ? As of now I am not worried
> about ksymoops.
> 

I think "strip --strip-unneeded" is what you want.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
