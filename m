Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTEHS7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTEHS7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 14:59:22 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:49894 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262036AbTEHS7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 14:59:21 -0400
Message-ID: <3EBAAB9D.5000508@shemesh.biz>
Date: Thu, 08 May 2003 22:10:21 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en, he
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Terje Eggestad <terje.eggestad@scali.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>, D.A.Fedorov@inp.nsk.su,
       Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com> <1052398474.4849.57.camel@pc-16.office.scali.no> <20030508135839.A6698@infradead.org>
In-Reply-To: <20030508135839.A6698@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>Maybe you have a different notion of proper mechanism then everyone
>else.
>
Out of personal interest - would a mechanism that promised the following 
be considered a "proper mechanism"?
1. Work on all platforms.
2. Allow load and unload in arbitrary order and timings (which also 
means "be race free").
3. Have low/zero overhead if not used

Would you also require:
4. Have reasonable overhead when used
a "must have" demand? Would, on the other hand, a:
4b. Have zero overhead when used for functions not hooked
be an alternative demand?

I'm currently trying to work with some other subscribers of this list on 
a design. Getting 1, 2 and 3 is a complicated enough task, of course. I 
would like to hear estimates about inclusion chances should we manage to 
come up with an implmentation that lives up to all the above.

             Thanks,
                Shachar

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


