Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUHGLk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUHGLk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 07:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUHGLku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 07:40:50 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:30081 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261610AbUHGLkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 07:40:46 -0400
Date: Sat, 7 Aug 2004 13:40:46 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040807114046.GA5249@ucw.cz>
References: <200408071128.i77BSNCd006957@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408071128.i77BSNCd006957@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> You wanted to get a description in 'a few words' - this cannot be done.
> 
> .... So I instucted you how to get the full desciption. 
> 
> You may of course look yourself for the documentation at docs.sun.com.......
> 
> It seems that you are not really interested to understand how it works :-(

I am interested, but I life is too short to read the full docs of all existing
OS's. Can you give me at least a pointer to the relevant section?

> If you behave this way, I tend to believe that you have a precasted opinion 
> that you are not willing to change.

I think that most people around there tend to believe exactly the same about you :-)
But let's change that.

Most of all, I would like to know (I see I'm repeating myself, but I still
haven't seen an answer to that) what's so special about the SCSI-like devices,
that they would have to be addressed in a completely different way from the
other UNIX devices. For the classical SCSI, you might argue that addressing
by the physical topology is more realistic, but for ATAPI or USB disks,
the SCSI triplets have nothing to do with the physical topology.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Only dead fish swim with the stream.
