Return-Path: <linux-kernel-owner+w=401wt.eu-S1760582AbWLKNcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760582AbWLKNcx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762911AbWLKNcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:32:53 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:45731 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760582AbWLKNcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:32:52 -0500
Message-ID: <457D5E01.7010307@garzik.org>
Date: Mon, 11 Dec 2006 08:32:49 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Akinobu Mita <akinobu.mita@gmail.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Mark bitrevX() functions as const
References: <457D559C.2030702@garzik.org>  <29447.1165840536@redhat.com> <15033.1165842882@redhat.com>
In-Reply-To: <15033.1165842882@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
>> * naked __attribute__ is ugly.  define something short and memorable in
>> include/linux/compiler.h.
> 
> I'm not sure that's a good idea.  You have to be careful not to cause confusion
> with ordinary "const".

It's all in the naming.  You could call it 'purefunc' or somesuch.

__attribute__ is very very ugly, an hinders a quick scan of the function 
prototype, particularly if it has a boatload of other attributes.


>> * another annotation to consider is C99 keyword 'restrict'.
> 
> Indeed, though I presume you don't mean in this particular case...

Correct.

	Jeff



