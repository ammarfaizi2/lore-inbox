Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269306AbUIHS45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269306AbUIHS45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUIHS45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:56:57 -0400
Received: from [81.23.229.73] ([81.23.229.73]:45007 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S269306AbUIHS4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:56:37 -0400
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: Ram Chandar <rcknl@qz.port5.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Routing Performance inferior?
Date: Wed, 8 Sep 2004 20:56:33 +0200
User-Agent: KMail/1.6.2
References: <200409071000.58455.rchandar-knl@qz.port5.com>
In-Reply-To: <200409071000.58455.rchandar-knl@qz.port5.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082056.33684.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BSD is known for good network performance, however I don't know benchmarks. 
I think the difference is to big: The routing/IP stack combined being 10 times 
less efficient is too much.

They also don't mention which linux kernel they use. Reading the 
FreeBSD-5.3-Networking.pdf they did some optimasations which are probably not 
advisable if you don't use your box as a router.
The goal of this person is as far as I can see to build a router only, so in 
theory you could build in the same optimasations in network stack of linux

Also look at page 11: The fastforwarding is a solid positive step on how a 
router should work. So even the performance of FreeBSD is not considered like 
a real router OS.



On Wednesday 08 September 2004 19:36, you wrote:
> Quoted from a recent mail to freebsd mailing list.
>
> "FreeBSD (5.x) can route 1Mpps on a 2.8G Xeon while
> Linux can't do much more than 100kpps"
>
> http://lists.freebsd.org/pipermail/freebsd-net/2004-September/004840.html
>
> Is this indeed the case?
>
> Ram Chandar.
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
