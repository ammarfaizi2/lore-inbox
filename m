Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271106AbTGWGJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271107AbTGWGJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:09:08 -0400
Received: from soft.uni-linz.ac.at ([140.78.95.99]:4831 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S271106AbTGWGJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:09:06 -0400
Message-ID: <3F1E29F6.5000104@gibraltar.at>
Date: Wed, 23 Jul 2003 08:23:50 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-at, de-de, en-gb, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jason Baron <jbaron@redhat.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4 and 2.4.22-pre7
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>	 <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>	 <3F1D7C80.6020605@gibraltar.at>	 <1058904025.4160.30.camel@dhcp22.swansea.linux.org.uk>	 <3F1DA09F.4020503@gibraltar.at> <1058910871.4674.0.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058910871.4674.0.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Alan Cox wrote:
> Give vanilla 2.4.22-pre7 a go. I suspect it'll break the same if its
> the unshare stuff
Yes, I can confirm that now. 2.4.22-pre7 with the patch-o-matic
netfilter stuff (which I need for the machine but IMHO shouldn't change
anything wrt. this problem) also has the same problem.

best regards,
Rene

