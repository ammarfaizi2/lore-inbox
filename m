Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWKGMRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWKGMRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWKGMRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:17:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:63673 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754223AbWKGMRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:17:08 -0500
Message-ID: <4550793F.4070102@garzik.org>
Date: Tue, 07 Nov 2006 07:17:03 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [take21 0/4] kevent: Generic event handling mechanism.
References: <11619654014077@2ka.mipt.ru> <45506D51.30604@garzik.org> <20061107115111.GA13028@2ka.mipt.ru>
In-Reply-To: <20061107115111.GA13028@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Well, kevent network and FS AIO are suspended for now (although first

Why?

IMO, getting async event submission right is important.  It should be 
designed in parallel with async event reception.

	Jeff


