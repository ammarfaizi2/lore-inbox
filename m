Return-Path: <linux-kernel-owner+w=401wt.eu-S1762905AbWLKNxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762905AbWLKNxM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762912AbWLKNxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:53:12 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:45893 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762905AbWLKNxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:53:10 -0500
Message-ID: <457D62C1.2030306@garzik.org>
Date: Mon, 11 Dec 2006 08:53:05 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Mark bitrevX() functions as const
References: <29447.1165840536@redhat.com> <457D559C.2030702@garzik.org> <je3b7m5zae.fsf@sykes.suse.de>
In-Reply-To: <je3b7m5zae.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> * another annotation to consider is C99 keyword 'restrict'.
> 
> This is useless as long as we compile with -fno-strict-aliasing (and I
> don't think this will ever change).

Yes, just as useless as __attribute__((bitwise))... :)

	Jeff


