Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUAWLYs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 06:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUAWLYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 06:24:48 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:24082 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S266554AbUAWLYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 06:24:46 -0500
Date: Fri, 23 Jan 2004 11:24:44 +0000
From: John Levon <levon@movementarian.org>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: logic error in radeonfb.
Message-ID: <20040123112444.GB81582@compsoc.man.ac.uk>
References: <E1Ajuub-0000xr-00@hardwired> <1074840394.949.200.camel@gaston> <20040123065410.GF9327@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123065410.GF9327@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AjzQb-000IdB-N9*oyc6XX7pnng*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 06:54:10AM +0000, Dave Jones wrote:

> Back then someone came up with a cool one-liner that grepped for
> suspicious if's with !'s, it seems no-one ever did the same for 2.6,
> as there were a few others (see seperate mails for patches).

Actually I did make a one-liner for 2.6, and found rather a lot (15 or
so if I remember correctly). I also went as far as hacking up something
in gcc, but it was too flaky to go in and I haven't got round to fixing
it up yet.

Some of them were right under our noses for ages:

http://linus.bkbits.net:8080/linux-2.5/user=levon/patch@1.889.272.4?nav=!-|index.html|stats|!+|index.html|ChangeSet|cset@1.889.272.4

If you like I can see if I can dig up the gcc patch or the one-liner.

regards,
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
