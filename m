Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271934AbTHRWFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275202AbTHRWFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:05:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11196 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271934AbTHRWFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:05:06 -0400
Message-ID: <3F414D82.1030004@pobox.com>
Date: Mon, 18 Aug 2003 18:04:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Andries.Brouwer@cwi.nl, Dominik.Strasser@t-online.de, hch@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: headers
References: <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl> <20030818145709.0b5e162a.rddunlap@osdl.org>
In-Reply-To: <20030818145709.0b5e162a.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Hm, interesting.
> 
> Since there are 20+ <arch>/signal.h files and they don't always agree
> on signal bit numbers e.g., do we have 20+ abi/arch/signal.h files?
> Or 1 abi/signal.h file with many #ifdefs?  ugh.
> 
> The ABI is still per-arch, right?  Not _one ABI_ for any/all arches.


Correct.  So there would be an include/abi/i386 or include/abi/arch/i386 
or whatever, in addition to regular 'ole include/abi.  Or maybe 
include/asm-$arch/abi.  Take your pick :)  Arch separation is definitely 
a requirement, as you guessed.

	Jeff



