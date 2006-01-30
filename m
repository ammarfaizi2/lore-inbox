Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWA3Tt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWA3Tt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWA3Tt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:49:28 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15109 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964931AbWA3Tt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:49:27 -0500
To: thockin@hockin.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.1: UDP fragments >27208 bytes lost with ne2k-pci on
 DP83815
References: <87slr79knc.fsf@amaterasu.srvr.nix>
	<8764o23j0s.fsf@amaterasu.srvr.nix>
	<1138566075.8711.39.camel@lade.trondhjem.org>
	<871wyq3dl3.fsf@amaterasu.srvr.nix>
	<1138572140.8711.82.camel@lade.trondhjem.org>
	<874q3lwt7w.fsf@amaterasu.srvr.nix>
	<1138640968.30641.3.camel@lade.trondhjem.org>
	<87vew1vd03.fsf_-_@amaterasu.srvr.nix>
	<20060130190306.GA19227@hockin.org>
	<87vew1ttz7.fsf@amaterasu.srvr.nix>
	<20060130193224.GA21500@hockin.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: there's a reason it comes with a built-in psychotherapist.
Date: Mon, 30 Jan 2006 19:49:06 +0000
In-Reply-To: <20060130193224.GA21500@hockin.org> (thockin@hockin.org's
 message of "Mon, 30 Jan 2006 11:32:24 -0800")
Message-ID: <87ek2pts25.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Pruned Trond from the Cc:, this isn't an NFS bug after all]

On Mon, 30 Jan 2006, thockin@hockin.org said:
> I can't imagine what kind of hidden bug would lay dormant for 4 years and
> then pop up for just one person.  I don't know what I can offer except
> extra eyes  to vet any potential solutions.  Happt Hunting.

I'll verify that the cause really is the network card shortly (by
swapping the network cards I use for ADSL and internal networking:
the ADSL link has very little large UDP traffic). This'll let us
localize the problem to the NIC, or not, as the case may be.

More once this is done.

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
