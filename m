Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbUDPTfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbUDPTfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:35:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36571 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263653AbUDPTfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:35:00 -0400
Message-ID: <40803553.2030403@pobox.com>
Date: Fri, 16 Apr 2004 15:34:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mukker, Atul" <Atulm@lsil.com>
CC: "'Christoph Hellwig'" <hch@infradead.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][RELEASE]: megaraid unified driver version 2.20.0.B
 1
References: <0E3FA95632D6D047BA649F95DAB60E57033BC53D@exa-atlanta.se.lsil.com> <40803154.3070707@pobox.com>
In-Reply-To: <40803154.3070707@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> If there is a static maximum of scbs for megaraid hardware, dynamically 
> allocating scbs in ->queuecommand is a waste of time.
> 
> In my drivers, I pre-allocate driver-specific per-request structures -- 
> just like the SCSI layer does ;-)

Slight correction... it looks like SCSI dynamically allocates requests 
these days.

That doesn't change my core argument, however.

	Jeff



