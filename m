Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTFYT2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbTFYT2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:28:04 -0400
Received: from mail.ithnet.com ([217.64.64.8]:45327 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264968AbTFYT2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:28:00 -0400
Date: Wed, 25 Jun 2003 21:42:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       kpfleming@cox.net, stoffel@lucent.com, gibbs@scsiguy.com,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030625214221.2cd9613f.skraw@ithnet.com>
In-Reply-To: <20030625191655.GA15970@alpha.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030625191655.GA15970@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003 21:16:55 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> On Wed, Jun 25, 2003 at 01:43:53AM +0200, Stephan von Krawczynski wrote:
> > > Ah, OK ! I didn't understand this. You're right, this is also a
> > > possibility. Perhaps a tar cf - /mnt/3ware | chkblk would get evidence of
> > > somme corruption?
> > 
> > Hm, probably a dumb question: does repeated tar'ing of the same files lead
> > to exactly the same archive? There is no timestamp inside or something
> > equivalent?
> 
> Hmmm no, you're right, I forgot about this case. I think that access time or
> other time-dependant informations may change often enough to make a big diff
> on checksums. I have no more idea at the moment. Or perhaps tar to a disk
> file instead of the tape and check that file :-/

I have tried that already but never managed to get verification errors on tar
archives written to disk.
Maybe I try again some more...

Regards,
Stephan
