Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278108AbRJRUCW>; Thu, 18 Oct 2001 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278113AbRJRUCM>; Thu, 18 Oct 2001 16:02:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S278108AbRJRUCC>; Thu, 18 Oct 2001 16:02:02 -0400
Date: Thu, 18 Oct 2001 16:02:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: kuznet@ms2.inr.ac.ru
cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
In-Reply-To: <200110181925.XAA04814@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.3.95.1011018155423.4619A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > I (and others) have asked this a couple times here and on the netdev list, and
> > so far nobody has answered it (not even negatively).
> 
> :-) And me answered to this hundred of times: "no way". :-)
> 
> Ability to add/delete them with "ip neigh" will be removed in the next
> snapshot as well. The feature is obsolete.
> 
> Alexey
> -

I need the ability to delete an arp cache entry using `arp -d ...`.
Is this being removed? If so, I can't test embedded systems that
all come alive with a phony IEEE station address. Software normally
re-programs the SEEPROM with a real IEEE station address from a
data-base, over the network. The target is then restarted to
enable the new IEEE station address, and the server has the old
one deleted from its arp cache. Failure to delete the arp cache
entry results in a failure to connect, or a timeout of 5 minutes
for the arp cache entry to expire. Either one can't be acceptible
in automated testing.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


