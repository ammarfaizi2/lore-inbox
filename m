Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263133AbTDBUgM>; Wed, 2 Apr 2003 15:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbTDBUgM>; Wed, 2 Apr 2003 15:36:12 -0500
Received: from main.gmane.org ([80.91.224.249]:48773 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S263133AbTDBUgL>;
	Wed, 2 Apr 2003 15:36:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Dennis Cook" <cook@sandgate.com>
Subject: Re: Deactivating TCP checksumming
Date: Wed, 2 Apr 2003 15:47:35 -0500
Organization: Sandgate Technologies
Message-ID: <b6fi8m$j4g$1@main.gmane.org>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com> <20030401122824.GY29167@mea-ext.zmailer.org> <b6fda2$oec$1@main.gmane.org> <20030402203653.GA2503@gtf.org>
X-Complaints-To: usenet@main.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Cc: kernelnewbies@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I was looking for is a general capability to keep the SW transport
stack from
computing outgoing TCP/UDP/IP checksums so that the HW can be allowed to do
it,
similar to Windows checksum offload capability.

"Jeff Garzik" <jgarzik@pobox.com> wrote in message
news:20030402203653.GA2503@gtf.org...
> On Wed, Apr 02, 2003 at 02:22:59PM -0500, Dennis Cook wrote:
> > Using RH Linux kernel 2.4.18, setting "features" bit NETIF_F_IP_CSUM
does
> > not appear
> > to keep a valid IP checksum from being computed in packets presented to
my
> > driver
> > for transmission. So having HW compute outgoing checksum buys nothing.
>
> You are not using sendfile(2), which is required to activate h/w csum.
>
> Jeff
>
>
>



