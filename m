Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVI2PI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVI2PI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVI2PI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:08:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44523 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932174AbVI2PI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:08:58 -0400
Message-ID: <433C0382.10404@pobox.com>
Date: Thu, 29 Sep 2005 11:08:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281530190.19896-100000@master.linux-ide.org> <433C0285.3050106@adaptec.com>
In-Reply-To: <433C0285.3050106@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
>   hardware implementation  (interconnect, SAM 4.15, 1.3)
>       firmware implementation  (interconnect, SDS, SAM 4.6, 1.3)
>           LLDD                     (SAM, section 5, 6, 7)
>              Transport Layer          (SAM 4.15, SAS)
>                   SCSI Core             (SAM section 4,5,8)
>                      Commmand Sets        (SAM section 1)

Transport class + libsas achieves this.

Maybe I will have to demonstrate using code...

	Jeff


