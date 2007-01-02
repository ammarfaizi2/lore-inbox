Return-Path: <linux-kernel-owner+w=401wt.eu-S1755317AbXABPkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbXABPkg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbXABPkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:40:36 -0500
Received: from rtr.ca ([64.26.128.89]:2000 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755317AbXABPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:40:35 -0500
Message-ID: <459A7CF2.9060509@rtr.ca>
Date: Tue, 02 Jan 2007 10:40:34 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Rene Herman <rene.herman@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <20070101213601.c526f779.akpm@osdl.org> <20070102084447.GS2483@kernel.dk> <459A32E5.70506@gmail.com> <20070102115757.GT2483@kernel.dk> <20070102121048.GU2483@kernel.dk> <459A7646.1070007@rtr.ca> <20070102151401.GG2483@kernel.dk>
In-Reply-To: <20070102151401.GG2483@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
>> I did have to massage the second patch to get it to apply cleanly
>> after the first patch.  You may want to regenerate it against -rc3.
> 
> Hmm odd, I thought I did. Will double check.

Ahh.. I get it now.

I tried to apply the second patch *on top* of the first patch,
whereas it was supposed to be a full replacement instead.

Cheers

