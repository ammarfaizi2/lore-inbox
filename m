Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWEIQwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWEIQwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWEIQwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:52:54 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:55064 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750734AbWEIQwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:52:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c83z8EA54VcdQBf/DCDLbD/v8EejRiUUTPJc5A/L2YmeQdS2NzqgNyg4dUNjPkUNPWuq5XtpCCjR0K6s74OeIcbE2y3t/boVvy3YDcrQXLVGYOFMxz8msF4cMB36GfdWSIcXvr8pq/55RD5DwIE8VWLCJcCSZ5FKkNLSRpRaPtg=
Message-ID: <3b0ffc1f0605090952p6afb2eebjfa33fdf8af56997a@mail.gmail.com>
Date: Tue, 9 May 2006 12:52:53 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA patch update
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147177496.3172.64.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147104400.3172.7.camel@localhost.localdomain>
	 <3b0ffc1f0605081029o604e5a3eu62f58b765a10bf65@mail.gmail.com>
	 <1147177496.3172.64.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2006-05-08 at 13:29 -0400, Kevin Radloff wrote:
> > Thanks for the update. I'm still getting the same oops when inserting
> > a CF card, though:
>
> Different oops I think 8) I've fixed that one now although it may well
> be that ide2 once I release it now oopses where it did before the PCMCIA
> change rather than where it did this time.

Ahh, yes.. no longer through alloc_io_space. And the setup_irq
message/trace is new. ;)

Is there anything I can do to help debug this?

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
