Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311307AbSCLSMb>; Tue, 12 Mar 2002 13:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311304AbSCLSMV>; Tue, 12 Mar 2002 13:12:21 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:46183 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S311303AbSCLSMF>; Tue, 12 Mar 2002 13:12:05 -0500
Subject: Re: [patch] ns83820 0.17
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020312.031509.53067416.davem@redhat.com>
In-Reply-To: <20020312004036.A3441@redhat.com>
	<51A3E836-35A8-11D6-A4A8-000393843900@metaparadigm.com> 
	<20020312.031509.53067416.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 12 Mar 2002 13:12:32 -0500
Message-Id: <1015956757.4220.3.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-03-12 at 06:15, David S. Miller wrote:

> Use a cross-over cable to play with Jumbo frames, that is
> what I do :-)
> 
> Later this week I'll rerun tests on all the cards I have
> (Acenic, Sk98, tigon3, Natsemi etc.) with current drivers
> to see what it looks like with both jumbo and non-jumbo
> mtus over gigabit.

I no longer have the original, so I will just have to respond to this
one, since it is related.  I know I know nearly nothing about
networking, but here has been my thinking.

David, you believe we don't need NAPI.  You believe we perform fine
without it.  Here is my question.  A PCI bus, IRC, has about 500
Megabytes/sec of bandwidth.  A full blown gigabit Ethernet stream should
be around 133 Megabytes/sec.  Sounds to me like a PC could act easily
(As far as bandwidth is concerned) as a 4 to 5 port gigabit Ethernet
router.

How well does this work with NAPI and how well does it work without?  Is
NAPI a gain here?

Maybe there are other issues involved that I am unaware of, if there
are, I would still like to see how the theoretical answers pan out.

Thank you,
Trever Adams

