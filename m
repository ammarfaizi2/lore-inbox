Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTKJTsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTKJTsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:48:09 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:52677 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264105AbTKJTsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:48:07 -0500
Message-ID: <3FAFEB6A.9030206@colorfullife.com>
Date: Mon, 10 Nov 2003 20:47:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
References: <20031108162737.GB26350@vana.vc.cvut.cz> <20031110161114.GM10144@redhat.com> <3FAFC1D1.3090309@colorfullife.com> <20031110165654.GS10144@redhat.com> <3FAFC831.4090108@colorfullife.com> <20031110180551.GA20168@vana.vc.cvut.cz> <3FAFDFFF.70100@colorfullife.com> <3FAFE8D5.4020102@kolumbus.fi>
In-Reply-To: <3FAFE8D5.4020102@kolumbus.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Penttilä wrote:

> afaics, agp uses change_apge_attr() to turn on NOCACHE bit, and 
> doesn't remove the mapping.

Ops, you are right. Hmm. I'll add code to /dev/mem for DEBUG_PAGEALLOC, 
but it might take some time.

--
    Manfred


