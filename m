Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVAJOjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVAJOjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVAJOjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:39:52 -0500
Received: from smtpout.mac.com ([17.250.248.97]:25318 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262278AbVAJOjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:39:41 -0500
In-Reply-To: <41E27D29.2040001@grupopie.com>
References: <20050107190536.GA14205@mtholyoke.edu> <20050107213943.GA6052@pclin040.win.tue.nl> <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com> <s5gzmzjbza1.fsf@egghead.curl.com> <Pine.LNX.4.61.0501100735210.19253@chaos.analogic.com> <41E27D29.2040001@grupopie.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <747C0668-6315-11D9-B875-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux kernel <linux-kernel@vger.kernel.org>, linux-os@analogic.com,
       "Patrick J. LoPresti" <patl@curl.com>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: /dev/random vs. /dev/urandom
Date: Mon, 10 Jan 2005 15:39:38 +0100
To: Paulo Marques <pmarques@grupopie.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2005, at 14:03, Paulo Marques wrote:

>> In the first place, the problem was to display the error of using
>> an ANDing operation to truncate a random number. In the limit,
>> one could AND with 0 and show that all randomness has been removed.
>
> Not really.. you just get a perfect random uniform distribution if the 
> range [0..0] :)

I would say that a sample space (omega) of one unique element cannot be 
considered entirely random. For that if you perform the random 
experiment, you will always get that unique sample, and thus p(Sample) 
= p(Omega) = 1.

Let Omega = { 0 }, thus p(Omega) = p(0) = 1, which I wouldn't consider 
random at all.

