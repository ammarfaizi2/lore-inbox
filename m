Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTDJROk (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTDJROk (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:14:40 -0400
Received: from imap.gmx.net ([213.165.65.60]:30699 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264105AbTDJROj convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 13:14:39 -0400
Message-ID: <3E95A932.9030301@gmx.net>
Date: Thu, 10 Apr 2003 19:26:10 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre6 problem with 8139too Fast Ethernet driver 0.9.26
References: <Pine.OSF.4.51.0304101852250.408246@tao.natur.cuni.cz>
In-Reply-To: <Pine.OSF.4.51.0304101852250.408246@tao.natur.cuni.cz>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ© wrote:
> Hi,
>   I'm observing sporadic problems with my onboard network card:
> 
> [...]
> $ mii-tool --verbose
> eth0: 10 Mbit, half duplex, link ok
>   product info: vendor 00:00:00, model 0 rev 0
>   basic mode:   10 Mbit, half duplex
>   basic status: link ok
>   capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
>   advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
> $
> 
> Any ideas? Please cc me in replies.

What type is the link partner (switch,hub,network card)? Type of cable
(crossover,plain)? How high is the traffic on the network?
Judging from your mii-tool output, you are connected to
1. a 10MBit hub or
2. a 100MBit hub and one of the connected network cards is 10MBit or
3. a 10MBit network card.
If neither of these is the case, please check your cabling.

Regards,
Carl-Daniel

-- 
http://www.hailfinger.org/

