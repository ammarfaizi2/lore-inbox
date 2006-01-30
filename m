Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWA3TZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWA3TZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWA3TZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:25:28 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:41606 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932381AbWA3TZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:25:27 -0500
Date: Mon, 30 Jan 2006 11:32:24 -0800
From: thockin@hockin.org
To: Nix <nix@esperi.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.1: UDP fragments >27208 bytes lost with ne2k-pci on DP83815
Message-ID: <20060130193224.GA21500@hockin.org>
References: <87slr79knc.fsf@amaterasu.srvr.nix> <8764o23j0s.fsf@amaterasu.srvr.nix> <1138566075.8711.39.camel@lade.trondhjem.org> <871wyq3dl3.fsf@amaterasu.srvr.nix> <1138572140.8711.82.camel@lade.trondhjem.org> <874q3lwt7w.fsf@amaterasu.srvr.nix> <1138640968.30641.3.camel@lade.trondhjem.org> <87vew1vd03.fsf_-_@amaterasu.srvr.nix> <20060130190306.GA19227@hockin.org> <87vew1ttz7.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vew1ttz7.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 07:07:40PM +0000, Nix wrote:
> On Mon, 30 Jan 2006, thockin@hockin.org prattled cheerily:
> > I've never heard anything like that.  I don't have many of these cards
> > around, but Cobalt shipped tens of thousands, and I don't hear of anything
> > resembling this.
> 
> Ah, it's always nice to be first with a bug.
> 
> Any idea how I could go about diagnosing this? (I'm fairly sure it's
> not the server end that's at fault, because that end is sending to other
> machines fine and was sending to this machine fine before it had a
> motherboard and network card change.)
> 
> I've never really dealt with NIC-layer problems before so I don't know
> what beyond printk() is provided, if anything. (Some clues about where
> to stick the printk()s might be useful too, although I can probably find
> them myself in time).

I can't imagine what kind of hidden bug would lay dormant for 4 years and
then pop up for just one person.  I don't know what I can offer except
extra eyes  to vet any potential solutions.  Happt Hunting.

