Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266267AbUGOSHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUGOSHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 14:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGOSHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 14:07:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60091 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266267AbUGOSHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 14:07:47 -0400
Message-ID: <40F6C7D3.1070005@pobox.com>
Date: Thu, 15 Jul 2004 14:07:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Arnd Bergmann <arnd@arndb.de>, "Robert M. Stockmann" <stock@stokkie.net>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
References: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net> <40F35140.6020509@pobox.com> <200407141320.32608.arnd@arndb.de> <200407151937.43862.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200407151937.43862.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 14 of July 2004 13:20, Arnd Bergmann wrote:
> 
>>On Dienstag, 13. Juli 2004 05:04, Jeff Garzik wrote:
>>
>>>Whoever builds your kernels changed around the kernel configuration on
>>>you.
>>>
>>>SATA "disk naming" (what driver you use) did not change from 2.6.3 to
>>>2.6.7.
>>
>>The thing that changed is the new BLK_DEV_IDE_SATA option that defaults
>>to 'n', while before it was enabled implicitly.
> 
> 
> This is a quite fresh change (post 2.6.7) and should be fixed before 2.6.8.
> This option should default to 'y', we can put some runtime warning instead.
> 
> Jeff, do you agree?


It's a really tough question...  default=n will eliminate a lot of 
problems people are reporting on lkml, but default=y changes the disks 
for the few users not having problems.

It's a tough call...

	Jeff


