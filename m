Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270978AbTG1AJD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270976AbTG1AIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:08:25 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:16646 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S270978AbTG0X46 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:56:58 -0400
Message-ID: <200307280211590888.10957DD9@192.168.128.16>
In-Reply-To: <20030727165831.05904792.davem@redhat.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
 <200307280140470646.1078EC67@192.168.128.16>
 <20030727164649.517b2b88.davem@redhat.com>
 <200307280158250677.10891156@192.168.128.16>
 <20030727165831.05904792.davem@redhat.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 28 Jul 2003 02:11:59 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2003 at 16:58 David S. Miller wrote:

>> On 27/07/2003 at 16:46 David S. Miller wrote:
>> >Bas's problem can be solved by him giving a "preferred source"
>> >to each of his IPV4 routes and setting the "arpfilter" sysctl
>> >variable for his devices to "1".
>> 
>> Yes, it's another approach to solve his problem. But he must play with
>routing.
>
>Precisely he must, because he has misconfigured routes for the
>behavior he desires.
>
>His problem is about source address selection when trying to
>contact a given destination.

Bas said:
==
>but it turned out that this wasn't the case. On closer examination it
>turned out that any ARP request to a local IP resulted in a response,
>even if the devices were on different subnets or ethernet segments.
==

It's the "hidden" switch.... again.
I suppose that Bas can confirm it.

>It's totally illogical to say that it's easier for him to patch his
>kernel and reboot it than fix his route configuration.

Sure... it WOULD be the easiest thing if it would be into the kernel main stream. But it isn't, making linux behave different to other OS and systems without any way or feature to make it behave like the others.

Regards,
Carlos Velasco


