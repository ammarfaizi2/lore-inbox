Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbTGAGAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbTGAGAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:00:11 -0400
Received: from terminus.zytor.com ([63.209.29.3]:16308 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266001AbTGAF7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:59:32 -0400
Message-ID: <3F01269A.5030801@zytor.com>
Date: Mon, 30 Jun 2003 23:13:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI domain stuff
References: <bdr7a6$4eu$1@cesium.transmeta.com>	<1057039376.32118.3.camel@rth.ninka.net>	<3F0124FC.1010001@zytor.com> <20030630.230329.35692088.davem@redhat.com>
In-Reply-To: <20030630.230329.35692088.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: "H. Peter Anvin" <hpa@zytor.com>
>    Date: Mon, 30 Jun 2003 23:06:52 -0700
> 
>    Perhaps a libdirectio would be useful?
>    
> The details are very PCI specific, so what you'd be working
> on initially is a PCI centric library.
> 
> Over time things can be abstracted, but the initial PCI specific
> one would be good enough for xfree86 to link to and make use
> of which is a huge step in the right direction.
 >

Well, "PCI" in this case presumably means 
PCI/PCI-X/PCI-Express/AGP/HyperTransport, which covers an amazing number 
of the machines actually being used these days.  Obviously it doesn't 
apply to all, but as you say, it can be abstracted on over time.

	-hpa

