Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVJ2LIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVJ2LIY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVJ2LIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:08:24 -0400
Received: from sender-01.it.helsinki.fi ([128.214.205.139]:9638 "EHLO
	sender-01.it.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750949AbVJ2LIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:08:23 -0400
Date: Sat, 29 Oct 2005 14:08:19 +0300 (EEST)
From: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>
X-X-Sender: jmoheikk@rock.it.helsinki.fi
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
In-Reply-To: <200510291201.06613.ak@suse.de>
Message-ID: <Pine.OSF.4.61.0510291312160.426625@rock.it.helsinki.fi>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi>
 <p73vezhtkpy.fsf@verdi.suse.de> <Pine.OSF.4.61.0510290058420.417368@rock.it.helsinki.fi>
 <200510291201.06613.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005, Andi Kleen wrote:
> On Saturday 29 October 2005 00:06, Janne M O Heikkinen wrote:
>> PANIC: early exception rip ffffffff8023429f error 0 cr2 0
>> PANIC: early exception rip ffffffff8011893a error 0 cr2 ffffffffff5fd02
>
> And it boots with numa=noacpi ?

No, I get same panics with numa=noacpi or even with numa=off. If I compile
2.6.14 kernel without CONFIG_ACPI_NUMA it does boot.
