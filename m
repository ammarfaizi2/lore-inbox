Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVKQPls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVKQPls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVKQPls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:41:48 -0500
Received: from mail.gondor.com ([212.117.64.182]:45325 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1751016AbVKQPlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:41:47 -0500
Date: Thu, 17 Nov 2005 16:41:25 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Bart Samwel <bart@samwel.tk>
Cc: Bradley Chapman <kakadu@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051117154124.GA1813@knautsch.gondor.com>
References: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com> <437C9334.3020606@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437C9334.3020606@samwel.tk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 03:27:00PM +0100, Bart Samwel wrote:
> OK, that's the second report then. I'm beginning to worry. :/

And I'm not feeling so lonely any more ;-)

> Bradley, Jan, since when have these problems been happening? Kernel 
> version-wise, I mean?

I didn't notice these problems before 2.6.14. As these corruptions are
not happening very often, and as I usually do not run the notebook on
battery power, the problem may have existed for a while, though.

Today I did a simple test: I activated laptop mode with a 10s idle
timeout, and made a script write files with uniqe identifiers, followed
by a sync, every 60 seconds. After nearly an hour, I didn't see any
corruption, though at least some of these writes have triggered
a spin-up. When I have some spare time I'll do more intensive testing.

Additionally, I mounted more than half of the partitions on this
notebook read only, and made a 1:1 copy of these partitions to an
external hard drive. Therefore, I can check later if something
accidentally did write to these areas.

If you have any suggestions for additional test, please tell me.

The random filesystem corruption had one positive effect: I never had
such a good backup of my data before. ;-)

Jan

