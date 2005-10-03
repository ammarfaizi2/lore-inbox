Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVJCSvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVJCSvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVJCSvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:51:18 -0400
Received: from [81.2.110.250] ([81.2.110.250]:38839 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932585AbVJCSvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:51:17 -0400
Subject: Re: what's next for the linux kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051003005400.GM6290@lkcl.net>
References: <20051002204703.GG6290@lkcl.net>
	 <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
	 <20051002230545.GI6290@lkcl.net>
	 <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
	 <20051003005400.GM6290@lkcl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 20:18:40 +0100
Message-Id: <1128367120.26992.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 01:54 +0100, Luke Kenneth Casson Leighton wrote:
>  the message passing system is designed as a parallel message bus -
>  completely separate from the SMP and NUMA memory architecture, and as
>  such it is perfect for use in microkernel OSes.

I've got one of those. It has the memory attached. Makes a fantastic
message bus and has a really long queue. Also features shortcuts for
messages travelling between processors in short order cache to cache.
Made by AMD and Intel.

>  however, as i pointed out, 90nm and approx-2Ghz is pretty much _it_,
>  and to get any faster you _have_ to go parallel.

We do 512 processors passably now. Thats a lot of cores and more than
the commodity computing people can wire to memory subsystems at a price
people will pay. 

Besides which you need to take it up with the desktop people really. Its
their apps that use most of the processor power and will benefit most
from parallelising and efficiency work. 

Alan

