Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVBXHka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVBXHka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVBXHjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:39:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35488 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261890AbVBXH3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:29:22 -0500
Message-ID: <421D8241.9020608@pobox.com>
Date: Thu, 24 Feb 2005 02:29:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [8/14] Orinoco driver updates - PCMCIA initialization cleanups
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain> <20050224065527.GA8931@isilmar.linta.de>
In-Reply-To: <20050224065527.GA8931@isilmar.linta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
>>@@ -184,6 +186,7 @@
>> 	dev_list = link;
>> 
>> 	client_reg.dev_info = &dev_info;
>>+	client_reg.Attributes = INFO_IO_CLIENT | INFO_CARD_SHARE;
> 
> 
> That's not needed any longer for 2.6.

So who wants to send the incremental update patch?  :)

	Jeff



