Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966691AbWKUAKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966691AbWKUAKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966880AbWKUAKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:10:34 -0500
Received: from mail.tmr.com ([64.65.253.246]:36245 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S966691AbWKUAKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:10:33 -0500
Message-ID: <4562443C.2000005@tmr.com>
Date: Mon, 20 Nov 2006 19:11:40 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFSROOT with NFS Version 3
References: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de>	<1163780417.5709.34.camel@lade.trondhjem.org>	<20061120120750.1b1688e8.Christoph.Pleger@uni-dortmund.de>	<20061120135716.GA14122@tsunami.ccur.com> <20061120173311.154e54a6.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20061120173311.154e54a6.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Pleger wrote:
> Hello,
> 
> On Mon, 20 Nov 2006 08:57:16 -0500
> Joe Korty <joe.korty@ccur.com> wrote:
> 
>> On Mon, Nov 20, 2006 at 12:07:50PM +0100, Christoph Pleger wrote:
>>> Warning: Unable to open an initial console
>> This usually means /dev/console doesn't exist.  With many of
>> today's distributions, this means you didn't boot with a
>> initrd properly set up to run with your newly built kernel.
> 
> The device /dev/console exists, but init/main.c tries to open it
> read-write. As the nfsroot is mounted read-only, /dev/console cannot be
> opened read-write.

That doesn't sound right, but hum... try mounting noatime, perhaps some 
additional checking is being done.

Note: I'm pulling that out of the air, I haven't had a problem with it. 
Dare I assume that you checked the major,minor and all that good stuff?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
