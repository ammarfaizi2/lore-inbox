Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWA3S4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWA3S4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWA3S4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:56:17 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:51933 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S964872AbWA3S4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:56:16 -0500
Date: Mon, 30 Jan 2006 11:03:06 -0800
From: thockin@hockin.org
To: Nix <nix@esperi.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.1: UDP fragments >27208 bytes lost with ne2k-pci on DP83815 (was Re: persistent nasty hang in sync_page killing NFS (ne2k-pci / DP83815-related?), i686/PIII)
Message-ID: <20060130190306.GA19227@hockin.org>
References: <87fyn8artm.fsf@amaterasu.srvr.nix> <1138499957.8770.91.camel@lade.trondhjem.org> <87slr79knc.fsf@amaterasu.srvr.nix> <8764o23j0s.fsf@amaterasu.srvr.nix> <1138566075.8711.39.camel@lade.trondhjem.org> <871wyq3dl3.fsf@amaterasu.srvr.nix> <1138572140.8711.82.camel@lade.trondhjem.org> <874q3lwt7w.fsf@amaterasu.srvr.nix> <1138640968.30641.3.camel@lade.trondhjem.org> <87vew1vd03.fsf_-_@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vew1vd03.fsf_-_@amaterasu.srvr.nix>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 05:31:24PM +0000, Nix wrote:
> ... you are quite right. I'm mounting with an rsize and wsize of 32768
> (i.e., the default negotiated between a recent Linux NFS client and
> kernel server), and, completely consistently, 31504 bytes are sent and
> *only 27208 bytes are received*. This is so consistent that there's no
> way that this could be due to network congestion (unless it's getting
> jammed up inside the receiving NIC or something: it's an NE2K card and
> they're rather crap so maybe the card is just too slow: my determination
> to replace the card has just gone up a notch. But nonetheless if it was
> getting lost by the card I'd see TCP retransmissions, which `netstat -s'
> assures me I do not).
> 
> This explains why I don't see a problem with DNS: the number of DNS
> packets >27208 bytes can be counted on the fingers of one foot.
> 
> Captures are available, but I gathered about half a minute's traffic
> so they're quite large (1Mb apiece).
> 
> Tim? Any ideas? Is anyone else with this card seeing this problem?

I've never heard anything like that.  I don't have many of these cards
around, but Cobalt shipped tens of thousands, and I don't hear of anything
resembling this.

odd indeed.
