Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933208AbWKSUnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbWKSUnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbWKSUnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:43:14 -0500
Received: from h155.mvista.com ([63.81.120.155]:6318 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S933208AbWKSUnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:43:13 -0500
Message-ID: <4560C23D.6080304@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:44:45 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>		<1163966437.5826.99.camel@localhost.localdomain>		<20061119200650.GA22949@elte.hu>		<1163967590.5826.104.camel@localhost.localdomain>		<4560BDF5.400@ru.mvista.com>	<1163968376.5826.110.camel@localhost.localdomain> <4560C121.30403@ru.mvista.com>
In-Reply-To: <4560C121.30403@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Sergei Shtylyov wrote:

>>On MPIC or XICS, this is implicit by reading the vector. On some more
>>dumb controllers, this has to be done explicitely.

>     This is not implicit -- CPU has to read INTACK reg. on OpenPIC. Really 

    Sorry, it's the same for x86 version of OpenPIC according to spec. I meant 
the PPC implementation here.

>>Ben.

WBR, Sergei
