Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUADW7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265382AbUADW7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:59:55 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:61446
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265378AbUADW7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:59:53 -0500
Date: Sun, 4 Jan 2004 14:57:00 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: tomwallard@soon.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Any hope for HPT372/HPT374 IDE controller?
In-Reply-To: <S265365AbUADWL5/20040104221159Z+4976@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10401041431520.31033-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a version stable for the KT400 chipset, it is the KT600 which is
unstable now.  As soon as I finish resolving the issues one of my
customers is having with the KT600, it will be released shortly there
after.

Some of the problems appear with the APIC routing and interrupts being
lost and not begin processed.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 4 Jan 2004 tomwallard@soon.com wrote:

> Many people seem to have problems with the Highpoint HPT372 and HPT374 IDE
> controllers. Several months ago there was a thread in which many people
> reported failure and not many people reported success. For example, "hdX:
> lost interrupt" errors right before a crash are a common problem. This was
> happening over a wide range of kernel versions. In my case it happens more
> quickly if there is heavy network or video load at the same time as heavy
> load on this controller. (This is a motherboard with a KT400 chipset).
>                                                                                                     
> Have any recent improvements been made? Does anyone have one of these controllers actually working correctly? Does anyone have any idea where to
> begin tracking this problem down?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


