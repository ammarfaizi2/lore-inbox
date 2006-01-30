Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWA3THz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWA3THz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWA3THz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:07:55 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15879 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964883AbWA3THy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:07:54 -0500
To: thockin@hockin.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.1: UDP fragments >27208 bytes lost with ne2k-pci on
 DP83815
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	<1138499957.8770.91.camel@lade.trondhjem.org>
	<87slr79knc.fsf@amaterasu.srvr.nix>
	<8764o23j0s.fsf@amaterasu.srvr.nix>
	<1138566075.8711.39.camel@lade.trondhjem.org>
	<871wyq3dl3.fsf@amaterasu.srvr.nix>
	<1138572140.8711.82.camel@lade.trondhjem.org>
	<874q3lwt7w.fsf@amaterasu.srvr.nix>
	<1138640968.30641.3.camel@lade.trondhjem.org>
	<87vew1vd03.fsf_-_@amaterasu.srvr.nix>
	<20060130190306.GA19227@hockin.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: a learning curve that you can use as a plumb line.
Date: Mon, 30 Jan 2006 19:07:40 +0000
In-Reply-To: <20060130190306.GA19227@hockin.org> (thockin@hockin.org's
 message of "Mon, 30 Jan 2006 11:03:06 -0800")
Message-ID: <87vew1ttz7.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006, thockin@hockin.org prattled cheerily:
> I've never heard anything like that.  I don't have many of these cards
> around, but Cobalt shipped tens of thousands, and I don't hear of anything
> resembling this.

Ah, it's always nice to be first with a bug.

Any idea how I could go about diagnosing this? (I'm fairly sure it's
not the server end that's at fault, because that end is sending to other
machines fine and was sending to this machine fine before it had a
motherboard and network card change.)

I've never really dealt with NIC-layer problems before so I don't know
what beyond printk() is provided, if anything. (Some clues about where
to stick the printk()s might be useful too, although I can probably find
them myself in time).

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
