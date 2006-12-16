Return-Path: <linux-kernel-owner+w=401wt.eu-S1161162AbWLPQeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbWLPQeK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWLPQeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:34:10 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34751 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161162AbWLPQeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:34:07 -0500
Message-ID: <45841FFD.8030907@garzik.org>
Date: Sat, 16 Dec 2006 11:34:05 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support HDIO_GET_IDENTITY in libata
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org> <4581AEA0.3040708@garzik.org> <20061214202608.GA2313@codepoet.org> <4581B4A2.8070006@garzik.org> <20061214204046.GA2607@codepoet.org>
In-Reply-To: <20061214204046.GA2607@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Thu Dec 14, 2006 at 03:31:30PM -0500, Jeff Garzik wrote:
>> Erik Andersen wrote:
>>> +			if (!atapi_enabled && dev->class == ATA_DEV_ATAPI) {
>> This seems like an impossible condition?
> 
> Hmm, suppose so.  Do you think that simply doing:
> 	if (dev->class == ATA_DEV_ATAPI) {
> here would be sufficient?

Yep.  There is also a selection of helpers in include/linux/libata.h 
starting with ata_class_enabled() that might be useful.

	Jeff



