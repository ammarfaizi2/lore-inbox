Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWBKUOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWBKUOk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWBKUOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:14:39 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:40709 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S964788AbWBKUOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:14:39 -0500
Date: Sat, 11 Feb 2006 21:14:40 +0100
From: iSteve <isteve@rulez.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060211211440.3b9a4bf9@silver>
In-Reply-To: <43EE446C.8010402@cfl.rr.com>
References: <20060211103520.455746f6@silver>
	<m3r76a875w.fsf@telia.com>
	<20060211124818.063074cc@silver>
	<m3bqxd999u.fsf@telia.com>
	<20060211170813.3fb47a03@silver>
	<43EE446C.8010402@cfl.rr.com>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2006 15:09:16 -0500
Phillip Susi <psusi@cfl.rr.com> wrote:

> iSteve wrote:
> > 
> > Any plans or time estimation to support variable packet size?
> > 
> > BTW, can I currently work with packet writing if I only have a CDR? I know
> > it technically is possible, I've seen it done (not on Linux though), but I
> > wonder if it is possible with current codebase.
> 
> I've been working on this area lately and thought about implementing 
> such support, but I am still not even sure it can really be done, short 
> of hacking the udf filesystem to hell so it understands and issues 
> commands to burn the variable length packets.
> 
> How did you format the existing disc?  What does cdrwtool -i show?  My 
> guess is that you formatted this disc in windows or something and this 
> disc isn't using packet mode at all, but rather has been formatted for 
> mount rainier mode, in which case, you don't need pktcdvd at all to 
> write to it.
> 
I used cdrecord (via xcdroast) to blank the CDRW and then burn UDF image created
by mkudffs.

Can I get this mount rainer udf extension work using just this method, and then
mount it?

Are there any specific mkudffs option that can help me? Or am I absolutely
obliged to use cdrwtool if I want to even think about using packet writing or
any other method to mount a CDRW?
-- 
 -- iSteve
