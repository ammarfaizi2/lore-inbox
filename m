Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWBMAfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWBMAfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWBMAfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:35:14 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:1940 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751501AbWBMAfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:35:13 -0500
Message-ID: <43EFD42D.6040102@cfl.rr.com>
Date: Sun, 12 Feb 2006 19:34:53 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: iSteve <isteve@rulez.cz>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com> <2006021 <20060212114640.31765c3a@silver>
In-Reply-To: <20060212114640.31765c3a@silver>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iSteve wrote:
> 
> "without actually having to use UDF and packet writing on the burning
> side" ... sorry, should've been 'or'. I am trying to find a way that wouldn't
> require having packet writing support in kernel (or as module, of course) with
> the initial burning.

So you want to write data to the disc without using pktcdvd?  cdrwtool 
-f allows you to write an image file to the disc, though I don't see why 
you don't want to use pktcdvd.  If you want to be able to read/write the 
disc on the fly, you must either use pktcdvd or format the disc in MRW 
mode.

