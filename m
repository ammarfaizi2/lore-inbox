Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbTFRTZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbTFRTZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:25:50 -0400
Received: from mail.convergence.de ([212.84.236.4]:29914 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265511AbTFRTZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:25:34 -0400
Date: Wed, 18 Jun 2003 21:39:24 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Michael Hunold <hunold@convergence.de>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Holger Waechtler <holger@convergence.de>
Subject: Re: DVB updates, 3rd try
Message-ID: <20030618193924.GA10511@convergence.de>
References: <3EF051AF.1060006@convergence.de> <Pine.LNX.4.44.0306180849150.9782-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306180849150.9782-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Linus Torvalds wrote:
> 
> I don't go out to fetch patches, I really want to see them come to me (and
> even then preferably through a few people acting as quality control and
> maintainership).
> 
> And if there is no clear maintainership relationship and you need to send
> them directly to me, I really want plain-text patches (they can be big if
> needed), with:

It would be great if we could clarfiy DVB maintainership. It would
nice to "appoint" one maintainer to whom we should send the
patches. If no one else volunteers, we will send them to you directly,
if you want with Cc: to lkml.

Alan Cox was the first one to merge the DVB subsystem into his 2.5 kernel
tree, but hinted that future updates should be sent in your direction.
Maybe that was just because he was busy with the IDE drivers, maybe
there are other reasons. I don't know.

The code base for the DVB drivers has grown over the last 3..4 years,
and there was a lot of stuff we wanted to clean up before inclusion in
the kernel. The pre-halloween merge was somewhat too soon, and there
were considerable cleanups afterwards which resulted in rather large
patches. Even after this current patch set, there is already a pile of
stuff to be merged. But the drivers in our CVS are already in a stable
condition, so future patches might be smaller ;-)


Thanks,
Johannes
