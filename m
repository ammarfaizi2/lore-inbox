Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWKESSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWKESSI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 13:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWKESSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 13:18:08 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:42212 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161451AbWKESSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 13:18:05 -0500
Date: Sun, 5 Nov 2006 19:18:01 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <1162750470.31873.33.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611051916030.11107@artax.karlin.mff.cuni.cz>
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> 
 <1162691856.21654.61.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0611051813440.1513@artax.karlin.mff.cuni.cz>
 <1162750470.31873.33.camel@localhost.localdomain>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2006, Alan Cox wrote:

> Ar Sul, 2006-11-05 am 18:18 +0100, ysgrifennodd Mikulas Patocka:
>> Should IDE driver read back parameters after writing them before issuing
>> the command? That should fix this problem. (except when command
>>  is written badly)
>
> For "normal" usage I suspect not - the lack of ECC memory is probably
> more serious as is the lack of PCI parity checking.

I meant for the corruption on IDE cable ... I have 5 UDMA CRC errors over 
8 years of usage, so I can imagine someone could have command parameters 
corrupted too --- or are they transmitted in a more reliable way?

Mikulas
