Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbRFGTeZ>; Thu, 7 Jun 2001 15:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbRFGTeP>; Thu, 7 Jun 2001 15:34:15 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:243 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S263003AbRFGTeF>; Thu, 7 Jun 2001 15:34:05 -0400
Message-Id: <l0313031db7458697459b@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.21.0106071435580.1156-100000@freak.distro.conectiva>
In-Reply-To: <l0313031cb745811cfc17@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 7 Jun 2001 20:31:53 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Reap dead swap cache earlier v2
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >As suggested by Linus, I've cleaned the reapswap code to be contained
>> >inside an inline function. (yes, the if statement is really ugly)
>>
>> I can't seem to find the patch which adds this behaviour to the background
>> scanning.
>
>I've just sent Linus a patch to free swap cache pages at the time we free
>the last pte. (requested by himself)
>
>With it applied we should get the old behaviour back again.
>
>I can put it on my webpage if you wish.

Just copy it to me so I can replace the dead-swap hacks you introduced earlier.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


