Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVJVNax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVJVNax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 09:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVJVNax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 09:30:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:29412 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751346AbVJVNaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 09:30:52 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <435A3E56.8060704@s5r6.in-berlin.de>
Date: Sat, 22 Oct 2005 15:27:50 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Luben Tuikov <luben_tuikov@adaptec.com>,
       andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de>
In-Reply-To: <435A1793.1050805@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.413) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>      1. renovate the core (thereby break all command set drivers and
>         all transport subsystems),
>      2. update ~2 command set drivers and ~2 transport subsystems
>      3. validate the renovated core,
>      4. fix the conceptual errors of the renovated core (as well as
>         first few discovered bugs in the implementation),
>      5. update all other command set drivers,
>      6. update all transport subsystems where resources to do so are
>         available,

Step 6 probably involves the creation of a SPI transport layer. It 
implements former SPI related functionality of the core and may receive 
former code of the core. BTW, it may be a good idea to really defer this 
to step 6 instead of doing so in step 2.
-- 
Stefan Richter
-=====-=-=-= =-=- =-==-
http://arcgraph.de/sr/
