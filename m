Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265690AbUAMVnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUAMVnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:43:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50390 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265690AbUAMVmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:42:49 -0500
Date: Tue, 13 Jan 2004 22:42:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jens Benecke <jens-usenet@spamfreemail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1mm2: nforce2 / amd74xx IDE driver doesn't load
Message-ID: <20040113214238.GZ9677@fs.tum.de>
References: <2867040.OKCKYgd4AF@spamfreemail.de> <200401131756.03852.bzolnier@elka.pw.edu.pl> <bu1ccg$ouh$1@sea.gmane.org> <200401131924.51778.bzolnier@elka.pw.edu.pl> <1611511.Si9EDUbpBt@spamfreemail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611511.Si9EDUbpBt@spamfreemail.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 10:15:57PM +0100, Jens Benecke wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > On Tuesday 13 of January 2004 19:11, Jens Benecke wrote:
> > 
> >> PS: this worked in 2.4 (loading the IDE driver later as module, but
> >> booting from IDE as well), why doesn't it work in 2.6 any more?
> > 
> > Because 2.6.x is different (most host drivers probe for drives themselves)
> > and nobody fixed this issue :-).
> 
> Ok ... :) will reporting it here make somebody fix it for 2.6.2 or would I
> need to file an official bug report on the kernel bugzilla website?

I don't think any of these two possibilities will fix it foor 2.6.2.

The best way to get it fixed is most likely to send a patch that fixes 
it.  ;-)

> Jens Benecke

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

