Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269568AbUINRCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269568AbUINRCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbUINQ5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:57:24 -0400
Received: from [64.65.177.98] ([64.65.177.98]:2240 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S269571AbUINQnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:43:05 -0400
Message-ID: <41466963.702@pacrimopen.com>
Date: Mon, 13 Sep 2004 20:45:39 -0700
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040824)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Con Kolivas <kernel@kolivas.org>, jch@imr-net.com,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff Wells <clifford.wells@comcast.net>
Subject: Re: [ck] Re: 2.6.8.1-ck7, Two Badnessess, one dump.
References: <41412765.4010005@kolivas.org> <4144F691.6040405@pacrimopen.com> <41451957.7000101@kolivas.org> <4145BAE9.1040800@pacrimopen.com> <20040913191237.GF18883@suse.de>
In-Reply-To: <20040913191237.GF18883@suse.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Is your drive idle while applying dma settings? Current 2.6 kernels
>aren't even close to being safe to modify drive settings, since it makes
>no effective attempts to serialize with ongoing commands. I have a
>half-assed patch to fix that.
>
>  
>

No it isn't!!  But I think that would be the problem.  I just realized 
that [after you wrote this] that I turned on 'parallel' execution in my 
Gentoo init scripts for both of those systems.


Tonight, I am going to change hdparm so that it runs xfs_freeze on all 
fs's just before tuning, and [of course un-freeze] to see if that cures it.

thanks,
  Joshua

