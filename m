Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTLQGdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 01:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTLQGdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 01:33:07 -0500
Received: from fmr05.intel.com ([134.134.136.6]:37313 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263561AbTLQGdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 01:33:04 -0500
Message-ID: <3FDFF81F.7040309@intel.com>
Date: Wed, 17 Dec 2003 08:30:55 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: arjanv@redhat.com, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>  <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <Pine.LNX.4.58.0312160844110.1599@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312160844110.1599@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Hopefully, they (or we, should I count myself?) are not completely brain 
dead.
Old method still works.
All game is about to give full 4k. It will be required for new deices.
If all you need is PCI devices behind PCI-E/PCI brigde,
it will work fine with old method.

Vladimir.

Linus Torvalds wrote:

>On Tue, 16 Dec 2003, Vladimir Kondratiev wrote:
>  
>
>>I re-worked the patch. This time it uses fixmap; I added config
>>parameters to disable this code and to handle non-default base address.
>>    
>>
>
>Ok, this looks sane to me.
>
>However, I have a totally independent question: do new PCI Express host
>bridges really not just suppor the old PCI config access interface?
>
>Quite frankly, if I was a manager in charge of a PCI Express host bridge,
>and it didn't support the old C8C IO access patterns, I'd be so ashamed of
>myself that I'd kill my whole development team with rat poison, and then
>blame them for the mistake(*).
>
>Do we know of any sudden suspicious death waves inside certain groups at
>Intel?
>
>		Linus
>
>(*) That's how managers work, after all. Long gone are the days when
>personal shame caused you to take personal responsibility.
>  
>

