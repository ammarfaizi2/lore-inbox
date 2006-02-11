Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWBKUJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWBKUJn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWBKUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:09:43 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:51632 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S964785AbWBKUJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:09:42 -0500
Message-ID: <43EE446C.8010402@cfl.rr.com>
Date: Sat, 11 Feb 2006 15:09:16 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: iSteve <isteve@rulez.cz>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver>
In-Reply-To: <20060211170813.3fb47a03@silver>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iSteve wrote:
> 
> Any plans or time estimation to support variable packet size?
> 
> BTW, can I currently work with packet writing if I only have a CDR? I know it
> technically is possible, I've seen it done (not on Linux though), but I wonder
> if it is possible with current codebase.

I've been working on this area lately and thought about implementing 
such support, but I am still not even sure it can really be done, short 
of hacking the udf filesystem to hell so it understands and issues 
commands to burn the variable length packets.

How did you format the existing disc?  What does cdrwtool -i show?  My 
guess is that you formatted this disc in windows or something and this 
disc isn't using packet mode at all, but rather has been formatted for 
mount rainier mode, in which case, you don't need pktcdvd at all to 
write to it.

