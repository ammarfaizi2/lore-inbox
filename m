Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbVI3Xyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbVI3Xyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 19:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbVI3Xyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 19:54:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51592 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030506AbVI3Xyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 19:54:37 -0400
Message-ID: <433DD020.8000906@pobox.com>
Date: Fri, 30 Sep 2005 19:54:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Freemyer <greg.freemyer@gmail.com>
CC: Kyle Moffett <mrmacman_g4@mac.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>	 <433D8542.1010601@adaptec.com>	 <A0262C6F-6B0E-4790-BA42-FAFD6F026E0A@mac.com>	 <433D8D1F.1030005@adaptec.com>	 <0F03AA4B-D2D1-4C57-B81B-FC95CB863A98@mac.com> <87f94c370509301510nba59ac2m59f507f70de6e46b@mail.gmail.com>
In-Reply-To: <87f94c370509301510nba59ac2m59f507f70de6e46b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Freemyer wrote:
> Luben has more than once called for adding a small number of
> additional calls to the existing SCSI core.  These calls would
> implement the new (reduced) functionallity.  The old calls would
> continue to support the full SPI functionallity.  No existing  LLDD
> would need modification.

IOW, what Luben wants is:

	if (Luben)
		do this
	else
		do current stuff

If this is the case, why bother touching drivers/scsi/* at all?

Regards,

	Jeff


