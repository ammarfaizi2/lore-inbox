Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUHCKAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUHCKAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 06:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUHCKAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 06:00:18 -0400
Received: from smtpout3.uol.com.br ([200.221.11.56]:51072 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S265383AbUHCKAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 06:00:13 -0400
Date: Tue, 3 Aug 2004 06:59:35 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Jens Axboe <axboe@suse.de>
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wiggly@wiggly.org, dnarnold@yahoo.com, matt@mattcaron.net,
       seymour@astro.utoronto.ca
Subject: Re: cdrom: dropping to single frame dma
Message-ID: <20040803095935.GA1929@ime.usp.br>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	David Ford <david+challenge-response@blue-labs.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	wiggly@wiggly.org, dnarnold@yahoo.com, matt@mattcaron.net,
	seymour@astro.utoronto.ca
References: <41040A4B.6080703@blue-labs.org> <20040802132457.GT10496@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040802132457.GT10496@suse.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 02 2004, Jens Axboe wrote:
> On Sun, Jul 25 2004, David Ford wrote:
> > I got a single "cdrom: dropping to single frame dma" message which 
> > according to my research is part of the culprit.
> > 
> > I'm guessing that Jens' patch for this didn't make it into the kernel.
> 
> Try this.

I was having the same problems that David did.

In fact, I noticed that after I received the message "dropping to single
frame dma", everything that the CD drive ripped from that point on was just
digital silence.

With the patch sent by Jens, things seem to work well (just tried
extracting something that *did* generate the "single frame dma" message and
tried ripping another track and this latter track is, happily, not digital
silence).

I'm using an almost plain vanilla 2.6.7 kernel here (with a one-liner patch
to the USB hub controller).

Thanks Jens. I hope that this is included in the final 2.6.8.


Thanks again, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
