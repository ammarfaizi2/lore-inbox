Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270453AbRHHLHy>; Wed, 8 Aug 2001 07:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270454AbRHHLHo>; Wed, 8 Aug 2001 07:07:44 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:63238 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S270453AbRHHLHk>;
	Wed, 8 Aug 2001 07:07:40 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: john slee <indigoid@higherplane.net>
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1 is available. 
In-Reply-To: Your message of "Wed, 08 Aug 2001 17:38:00 +1000."
             <20010808173800.C2770@higherplane.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Aug 2001 21:07:45 +1000
Message-ID: <906.997268865@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001 17:38:00 +1000, 
john slee <indigoid@higherplane.net> wrote:
>On Wed, Aug 08, 2001 at 04:58:01PM +1000, Keith Owens wrote:
>>   Multiple targets can be specified on the same make command.  You
>>   cannot mix clean or mrproper with other targets but everything else
>>   can be put on one command.
>>     make -j oldconfig installable && sudo make -j install
>>   works beautifully.
>
>'make dep bzImage modules modules_install' has worked for me for a long
>long time...  am i just lucky?

make dep and modules_install could not be parallel run.  make bzImage
and make modules could parallel run using make -j.

