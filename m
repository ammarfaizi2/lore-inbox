Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWIEW1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWIEW1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 18:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWIEW1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 18:27:54 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:20930 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965231AbWIEW1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 18:27:53 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44FDF9BC.1000403@s5r6.in-berlin.de>
Date: Wed, 06 Sep 2006 00:27:08 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible	recursive	locking
 detected
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>	 <20060905111306.80398394.akpm@osdl.org>	 <44FDCEAD.5070905@s5r6.in-berlin.de> <1157490479.28193.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1157490479.28193.0.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-09-05 at 21:23 +0200, Stefan Richter wrote:
>> This information confuses me. These places are not supposed to be the
>> ones where the locks were actually acquired, are they?
> 
> they should be yes
> (but inlined functions get the name of the function they are inlined
> into)

Was there function inlining performed? E.g. on those functions that are
called from only one place?
-- 
Stefan Richter
-=====-=-==- =--= --==-
http://arcgraph.de/sr/
