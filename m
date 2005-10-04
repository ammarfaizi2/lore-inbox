Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVJDQes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVJDQes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVJDQes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:34:48 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:50102 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932455AbVJDQer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:34:47 -0400
Message-ID: <4342AF23.6000907@gentoo.org>
Date: Tue, 04 Oct 2005 17:34:43 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arthur Cosma <tux_fan@yahoo.ca>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Any news on PATA support for Promise PDC 20375?
References: <20051004160913.42155.qmail@web30513.mail.mud.yahoo.com>
In-Reply-To: <20051004160913.42155.qmail@web30513.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Cosma wrote:
> Please CC me only any reply to this message, as I am not a mailing list
> subscriber.
> 
> This was my last resort, as all searches on the subject topic yield
> messages from 2004, many of which mention Jeff Garzik's name.
> 
> After trying 2.6.13.2, I still don't get the PATA drives recognized, so I
> believe it's still not there yet.
> 
> The question is, will it ever be, or has it been dropped?

I'm attaching the patch included in Gentoo's 2.6.13 kernels, which originally
came from Jeff's repo.

I asked Jeff about this patch previously, and his comment was:

> However, this patch in particular is safe and OK -- it just needs cleaning
> up before including in 2.6.13, and I haven't figured out how to clean it up
> yet.  The port_flags[] array this patch adds is a hack.
> 
> I need to separate the port settings from the host settings, which would be
> the proper fix.

So I guess the answer is just wait a while longer (and patch manually for now) :)

Daniel
