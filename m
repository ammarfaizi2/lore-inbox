Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVCIUup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVCIUup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVCIUuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:50:11 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:24652 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262467AbVCIUtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:49:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dh0BX46EeSgvFcv0sKd8spWqYNzmjNm18z3rjA4rjkF6Xlco5uspfVvn/sVQGI4yZoHM5lHrjnKCT22ASkC9E5WerWCq7+EfrOaGUV9RBDdt/t4hWC2kxl4M2epQj3mpbXVRgcsqsaOFAJAvrFGmHZVVNhuFmHUKPuFizRo5bKs=
Message-ID: <5a2cf1f6050309124962088a0a@mail.gmail.com>
Date: Wed, 9 Mar 2005 21:49:01 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: VIA Rhine ethernet driver bug
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001001c4faf7$71a26230$450aa8c0@hierzo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <001001c4faf7$71a26230$450aa8c0@hierzo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2005 12:43:33 +0100, Udo van den Heuvel <udovdh@xs4all.nl> wrote:
> Hello,
> 
> On my firewall (VIA EPIA CL-6000 with VIA Rhine network chips running FC3
> and custom kernels) I see messages like:
> 
> Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
> buffers, entry 0x4 length 0 status 00000600!

That might be interesting to someone:

My VIA EPIA based machine  was working well until some minutes ago. I
accidently removed the power supply and the machine rebooted. From
then on I didn't have network anymore. The ethernet card (VIA Rhine
II) (static, not dhcp) was not working and "Oversized ...."  messages
were printed on the console.

I've rebooted twice and the network didn't still come up. Pinging a
machine on my LAN and pinging the box back resulted in > 98% of the
packets lost.

So I stopped the machine, let it rest for a minute or so and booted
again. That solved the problem.

So if you see the same message as Udo, try to let your box rest.

Jerome
