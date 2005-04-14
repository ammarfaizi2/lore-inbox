Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVDNWIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVDNWIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDNWIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:08:21 -0400
Received: from smtp2.netcologne.de ([194.8.194.218]:33458 "EHLO
	smtp2.netcologne.de") by vger.kernel.org with ESMTP id S261437AbVDNWIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:08:16 -0400
Message-ID: <425EE9CF.4030202@interia.pl>
Date: Fri, 15 Apr 2005 00:08:15 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
References: <425E9902.8000804@interia.pl> <20050414165535.GA15440@irc.pl>
In-Reply-To: <20050414165535.GA15440@irc.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
> On Thu, Apr 14, 2005 at 06:23:30PM +0200, Tomasz Chmielewski wrote:
> 
>>I have a Silicon Image SIL3112A SATA PCI controller + 2x 200GB, 8MB
>>Barracuda drives.
> 
> 
>  Bad combination.

OK, from the link you gave I can see that there might be some problems 
with SIL3112 controller + seagate disks...


>>The performance under 2.6 kernels is *very* poor (Timing buffered disk
>>reads never more than 20 MB/sec); under 2.4 it runs quite fine (Timing
>>buffered disk reads around 60 MB/sec).
> 
> 
>  2.4 risk data corruption. 2.6 sata_sil.c contains blacklist for some
> driver-controller combination.
> 
>  See: http://home-tj.org/m15w/

...but this link just doesn't explain why performance is sooo bad with 
2.6.11.x kernels (Timing buffered disk reads at 10-20 MB/sec), and is 
just OK with older 2.6 kernels (Timing buffered disk reads even at about 
100 MB/sec with 2.6.8.1).

any clue?

or should I wait for 2.6.11.7 (?), where it should be corrected?


Tomek


