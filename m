Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTFXX33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTFXX33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:29:29 -0400
Received: from mail.ithnet.com ([217.64.64.8]:29452 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263558AbTFXX32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:29:28 -0400
Date: Wed, 25 Jun 2003 01:43:53 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       kpfleming@cox.net, stoffel@lucent.com, gibbs@scsiguy.com,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030625014353.20ec0363.skraw@ithnet.com>
In-Reply-To: <20030624220331.GB2019@alpha.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030624220331.GB2019@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003 00:03:31 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> On Tue, Jun 24, 2003 at 11:26:09PM +0200, Stephan von Krawczynski wrote:
>  
> > sorry, you probably misunderstood my flaky explanation. What I meant was
> > not a cached block from the _tape_ (obviously indeed a char-type device)
> > but from the 3ware disk (i.e. the other side of the verification). Consider
> > the tape completely working, but the disk data corrupt (possibly not from
> > real reading but from corrupted cache).
> 
> Ah, OK ! I didn't understand this. You're right, this is also a possibility.
> Perhaps a tar cf - /mnt/3ware | chkblk would get evidence of somme corruption
> ?

Hm, probably a dumb question: does repeated tar'ing of the same files lead to
exactly the same archive? There is no timestamp inside or something equivalent
?

Regards,
Stephan
