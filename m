Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTGAUXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTGAUXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 16:23:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58064 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263637AbTGAUXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 16:23:46 -0400
Message-ID: <3F01F125.4060907@pobox.com>
Date: Tue, 01 Jul 2003 16:37:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ata-scsi driver update
References: <3F00CEDC.2010806@pobox.com>	 <1057086391.3444.3.camel@paragon.slim>  <3F01E030.9060201@pobox.com> <1057089782.3274.1.camel@paragon.slim>
In-Reply-To: <1057089782.3274.1.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> On Tue, 2003-07-01 at 21:25, Jeff Garzik wrote:
> 
> 
>>hmmm.  did you run a "make mrproper" or "make distclean" before 
>>building?  The above is a symptom of stale dependencies, not really any 
>>kernel patch.
> 
> 
> Ok I got it. I always get confused with directory names a and b in
> patches..;-) Compiling now. (BTW what is the proper way to apply such
> patches?)

Usually:

	cd <toplevel kernel directory>
	bzcat ../foo.patch.bz2 | patch -sp1

There is also scripts/patch-kernel script that you may play with.

	Jeff



