Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTJ0UB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTJ0UBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:01:25 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:41090 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263546AbTJ0UBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:01:24 -0500
Date: Mon, 27 Oct 2003 20:03:02 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200310272003.h9RK32B2001618@81-2-122-30.bradfords.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>
Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
In-Reply-To: <3F9D7666.6010504@pobox.com>
References: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com>
 <3F9D6891.5040300@namesys.com>
 <3F9D7666.6010504@pobox.com>
Subject: Re: Blockbusting news, results get worse
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jeff Garzik <jgarzik@pobox.com>:
> Hans Reiser wrote:
> > Mudama, Eric wrote:
> > 
> >>
> >> or put it under heavy write workload and remove
> >> power.
> >>
> > Can you tell us more about what really happens to disk drives when the 
> > power is cut while a block is being written?  We engage in a lot of 
> > uninformed speculation, and it would be nice if someone who really knows 
> > told us....
> > 
> > Do drives have enough capacitance under normal conditions to finish 
> > writing the block?  Does ECC on the drive detect that the block was bad 
> > and so we don't need to detect it in the FS?
> 
> 
> Does it really matter to speculate about this?
> 
> If you don't FLUSH CACHE, you have no guarantees your data is on the 
> platter.

I think that the idea that is floating around is to deliberately ruin
the formatting on part of the drive in order to simulate a bad block.

Operation of disk drives immediately after a power failiure has been
discussed before, by the way:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100665153518652&w=2

John.
