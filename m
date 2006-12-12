Return-Path: <linux-kernel-owner+w=401wt.eu-S1751238AbWLLLf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWLLLf2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 06:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWLLLf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 06:35:28 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:54786 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbWLLLf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 06:35:27 -0500
Message-ID: <457E93FB.20204@garzik.org>
Date: Tue, 12 Dec 2006 06:35:23 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] sata_nv: fix kfree ordering in remove
References: <456E3ED5.3090201@shaw.ca> <457D86F0.4020408@garzik.org> <457E3F6A.809@shaw.ca>
In-Reply-To: <457E3F6A.809@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jeff Garzik wrote:
>> It is unwise to free the struct before the ports are even detached.
> 
> Right, theoretically something bad could happen here (though not 
> likely). Here's a fix. Sorry for attaching with something so trivial, 
> but Thunderbird isn't very cooperative..

You'll need to resend the entire patch, I dropped it due to that 
comment.  In general, before a patch is applied, the patch will go 
through several revisions.  I don't apply things piecemeal, only the 
last (hopefully perfect:)) revision.

Also, as your email already guessed, attachments are to be avoided :/

	Jeff



