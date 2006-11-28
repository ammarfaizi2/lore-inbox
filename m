Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935795AbWK1KNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935795AbWK1KNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935796AbWK1KNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:13:40 -0500
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:1428 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S935795AbWK1KNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:13:39 -0500
Message-ID: <456C0BD0.7080606@tremplin-utc.net>
Date: Tue, 28 Nov 2006 11:13:36 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
MIME-Version: 1.0
To: Laurent Bigonville <l.bigonville@edpnet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O2micro smartcard reader driver.
References: <20061127182817.d52dfdf1.l.bigonville@edpnet.be>
In-Reply-To: <20061127182817.d52dfdf1.l.bigonville@edpnet.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11/27/2006 06:28 PM, Laurent Bigonville wrote/a écrit:
> Hi,
> 
> I found a thread (about one month old) about an OZ711Mx (O2micro mmc
> card reader) driver, but unfortunately it uses some closed-source
> code.[1] :(
> 
> But I found no thread about the kernel driver for the O2micro PCMCIA
> smartcard reader. So I would like to know if there is any chance that
> this driver may be included in the mainline kernel.
> The source are LGPL'ed and available via the musclecard website[2]. And
> I found a patch to make it compile with kernel > 2.6.13 on the ubuntu
> support site[3]. AFAIK the module work, the only issue I have is a
> small hang when inserting a card in the reader.
> 
> If some one could have a look at this.
> 

Hi,
Actually, this has been discussed on the MUSCLE mailing list (as implied 
in the ubuntu bug report): I've upgraded the driver to be compiled on 
2.6.17. It works fine (even better actually) with 2.6.18 and 2.6.19.

Latest version I've published is there:
http://pieleric.free.fr/o2scr/

Since then, I've cleaned up the code a bit, but no bug fix. I'll try to 
update the version when I'm back home today ;-)

Actually, I've never submitted the driver to the LKML mainly due to lack 
of test. I don't have any usable smartcard to check that everything 
works. If you could confirm it works, or tell me where it fails, it 
would be great!

c u,
Eric
