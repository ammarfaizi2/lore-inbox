Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVGPOP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVGPOP1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 10:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGPOP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 10:15:27 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:58539 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261619AbVGPOPZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 10:15:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AwwBdELWtMuiLRQ+kvNpxtuzewZt969szuGkCLypkt8QghooDCDUFsv9eN9yDc6jYabiCI1ULpXioawyFcmxbWxaLhP4WZTHK9mQZtyxTrTjqZMK7AzJVArZYHi/BcniHGYJ78aZUqkT7g0biIHT/nOgRjmFIHxs7PbTLlbSaug=
Message-ID: <90c25f270507160715259d38b@mail.gmail.com>
Date: Sat, 16 Jul 2005 19:45:24 +0530
From: Arvind Kalyan <base16@gmail.com>
Reply-To: Arvind Kalyan <base16@gmail.com>
To: linux-kernel@vger.kernel.org, FyD <fyd@u-picardie.fr>
Subject: Re: Module snd-intel8x0.ko broken in 2.6.12
In-Reply-To: <1121457027.42d8138341748@webmail.u-picardie.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1121457027.42d8138341748@webmail.u-picardie.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/05, FyD <fyd@u-picardie.fr> wrote:
> Here is the error message I get whatever the kernel 2.6.12 I use:
> FATAL: Error inserting snd-intel8x0
> (/lib/modules/2.6.12.2/kernel/sound/pci/snd-intel8x0.ko)
> unknown symbol in module or unknown parameter (see dmesg)

May be you chose additional modules that were interfering with symbols
in this module. Just take your old .config and run `make oldconfig`
then update as needed.

> Answer of dmesg:

[...]

Unrelated.

> Does it mean this module is broken in 2.6.12 ?

No, works fine for me.

Regards,
-- 
Arvind Kalyan
http://www.devforge.net/~arv
