Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUJORcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUJORcD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUJOR17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:27:59 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:28523 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268236AbUJOR1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:27:14 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZcUhYivbTNAa0dfa5EsbViTlbT5yh6As3UwOU1bvIXQuNHxFFDabS6w8H6wmqfewhHoEAVXLuOV1XVSvgheB0tbf05t6UFZqocDQRU+X0piuvaTAoljIHo5wpXwJzyNX72SyNYkDdrLTV9WAl1R0ZJvDfAO4QAblLhDLp50wBSU
Message-ID: <58cb370e0410151027687d204f@mail.gmail.com>
Date: Fri, 15 Oct 2004 19:27:10 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "a.ledvinka@promon.cz" <a.ledvinka@promon.cz>
Subject: Re: promise (105a:3319) unattended boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF77D5B4E1.A38CC6EC-ONC1256F2E.004E78A5-C1256F2E.0050B72C@promon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <OF77D5B4E1.A38CC6EC-ONC1256F2E.004E78A5-C1256F2E.0050B72C@promon.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to define 0 level RAID consisting of one disk only.
This works with Promise PATA, I dunno about SATA.

On Fri, 15 Oct 2004 16:41:37 +0200, a.ledvinka@promon.cz
<a.ledvinka@promon.cz> wrote:
> Hello.
> 
> Got here http://pciids.sourceforge.net/iii/?i=105a3319
> As http://linux.yyz.us/sata/faq-sata-raid.html#tx4 calls it
> soft/accelerator raid version
> Going to use latest kernel from /pub/linux/kernel/v2.4/
> 
> But bios even with keyboard unplugged requires me to press one of 2 keys
> to either define array OR continue booting in case no array is defined.
> 
> What would you recommend me to do?
> - stay with ft3xx module from promise  and 10 level RAID array and not use
> sata_promise?
> - define some array in bios and completely ignore that fact and use
> sata_promise, bypass bios and define custom linux soft raid arrays?
> - anything else (no bios flashing and no hw hacking)?
> 
> AlL.
> 
> please CC me... but anyway if you forget i will have a look into archive.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
