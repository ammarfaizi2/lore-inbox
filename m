Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUGHNit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUGHNit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUGHNit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:38:49 -0400
Received: from anatevka.vcpc.univie.ac.at ([131.130.186.140]:37056 "EHLO
	anatevka.vcpc.univie.ac.at") by vger.kernel.org with ESMTP
	id S261724AbUGHNiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:38:46 -0400
Message-ID: <40ED4E51.10904@vcpc.univie.ac.at>
Date: Thu, 08 Jul 2004 15:38:25 +0200
From: Willy Weisz <weisz@vcpc.univie.ac.at>
Organization: VCPC, European Centre for Parallel Computing at Vienna
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920 Netscape/7.0
X-Accept-Language: en-us, en, de-at, fr
MIME-Version: 1.0
To: Gabor Gombas <gombasg@sztaki.hu>
CC: Michael Buesch <mbuesch@freenet.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kaya <kaya@emailkaya.com>
Subject: Re: APIC error on CPU0:60(60)
References: <40EBFAF7.1080505@vcpc.univie.ac.at> <200407071914.44496.mbuesch@freenet.de> <20040708115849.GA32540@boogie.lpds.sztaki.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our kernel was also generated with CONFIG_PCI_USE_VECTOR enabled.
And according to a previuos mail by Mikael Petterson the value
60 related to sending and receiving vectors.

The problem only arises in one of our servers, the only one
with an Intel E7505 chipset. Is this related or pure coincidence?

Willy

Gabor Gombas wrote:

>On Wed, Jul 07, 2004 at 07:14:41PM +0200, Michael Buesch wrote:
>
>  
>
>>I can't say if the reason is not a faulty CPU. Maybe,
>>maybe not. Who knows.
>>    
>>
>
>Well, I have a machine which produces "APIC error" messages only if the
>kernel has been configured with CONFIG_PCI_USE_VECTOR enabled. Without
>CONFIG_PCI_USE_VECTOR, I get no APIC errors. The machine has a single
>1.7GHz P4 in it, and the kernel has ACPI, APIC and IO-APIC support all
>enabled. I can provide more detailed information if needed but it will
>take some time since the machine is not connected to any network.
>
>Gabor
>  
>
-----------------------------------------------------------

Willy Weisz

European Centre for Parallel Computing at Vienna (VCPC)
                 Nordbergstrasse 15/C312
                 A-1090 Wien
Tel: (+43 1) 4277 - 38824          Fax: (+43 1) 4277 - 9388
                e-mail: weisz@vcpc.univie.ac.at



