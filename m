Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVCPPVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVCPPVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVCPPVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:21:47 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:1664 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262633AbVCPPVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:21:19 -0500
Message-ID: <42384EE8.9000003@ribosome.natur.cuni.cz>
Date: Wed, 16 Mar 2005 16:21:12 +0100
From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050304
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols in	/lib/modules/2.4.28-pre2/xfree-drm/via_drv.o
References: <42384AB9.1080905@ribosome.natur.cuni.cz> <1110986170.6292.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1110986170.6292.20.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2005-03-16 at 16:03 +0100, Martin MOKREJŠ wrote:
> 
>>Hi,
>>  does anyone still use 2.4 series kernel? ;)
>># make dep; make bzImage; make modules
>>[cut]
>># make modules_install
>>[cut]
>>cd /lib/modules/2.4.30-pre3-bk2; \
>>mkdir -p pcmcia; \
>>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
>>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.30-pre3-bk2; fi
>>depmod: *** Unresolved symbols in /lib/modules/2.4.28-pre2/xfree-drm/via_drv.o
> 
> 
> this is not the module shipped by the kernel.org kernel...

Right. Sorry that I didn't say it more clearly, but I'm installing 2.4.30-pre3-bk2 kernel.
cd /usr/src/linux-2.4.30-pre3-bk2
make dep
make bzImage
make modules
make modules_install

and then I hit the error about some totally unrelated kernel version in /lib/modules? :(
Martin
