Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTFYTOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbTFYTOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:14:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:35593 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264959AbTFYTOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:14:41 -0400
Date: Wed, 25 Jun 2003 21:16:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, kpfleming@cox.net, stoffel@lucent.com,
       gibbs@scsiguy.com, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030625191655.GA15970@alpha.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com> <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com> <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com> <20030624220331.GB2019@alpha.home.local> <20030625014353.20ec0363.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030625014353.20ec0363.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 01:43:53AM +0200, Stephan von Krawczynski wrote:
> > Ah, OK ! I didn't understand this. You're right, this is also a possibility.
> > Perhaps a tar cf - /mnt/3ware | chkblk would get evidence of somme corruption
> > ?
> 
> Hm, probably a dumb question: does repeated tar'ing of the same files lead to
> exactly the same archive? There is no timestamp inside or something equivalent
> ?

Hmmm no, you're right, I forgot about this case. I think that access time or
other time-dependant informations may change often enough to make a big diff
on checksums. I have no more idea at the moment. Or perhaps tar to a disk file
instead of the tape and check that file :-/

Cheers,
Willy

