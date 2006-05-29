Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWE2PxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWE2PxO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 11:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWE2PxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 11:53:13 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:40940 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1751103AbWE2PxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 11:53:13 -0400
Message-ID: <447B18DB.3030805@nortel.com>
Date: Mon, 29 May 2006 09:52:59 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org,
       bidulock@openss7.org, Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com> <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org> <1148846131.27461.14.camel@mindpipe>  <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org> <447A883C.5070604@opensound.com> <1148883077.3291.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1148883077.3291.47.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2006 15:53:03.0915 (UTC) FILETIME=[F85137B0:01C68337]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2006-05-28 at 22:35 -0700, 4Front Technologies wrote:
> 
>>BTW, why is Mandriva the only distro to turn OFF REGPARM?. Again, I think 
>>distros shouldn't be given an option to turn it off if its a good thing to have.

> why not? It's not like it's a dramatic change of API after all... (and
> even if it were...)
> 
> external modules shouldn't care, they really really should inherit the
> cflags from the kernel's makefiles at which point.. the thing is moot.

Speaking from personal experience...there are a LOT of 3rd party drivers 
out there that do not build their modules properly.  It gets especially 
interesting when they want to have a single package support 2.4 and 2.6, 
and also link the result against an included binary blob.

Chris
