Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265828AbUFOSmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUFOSmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbUFOSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:42:31 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:385 "EHLO crianza")
	by vger.kernel.org with ESMTP id S265828AbUFOSma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:42:30 -0400
Date: Tue, 15 Jun 2004 14:42:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: more about serial console
Message-ID: <20040615184229.GA13604@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615000436.GA12516@porto.bmb.uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615000436.GA12516@porto.bmb.uga.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 08:04:36PM -0400, foo@porto.bmb.uga.edu wrote:
> The other weird thing I have seen is with the serial console.  After
> init loads the net bonding module and the network comes up, the serial
> console output stops, as though I had typed ^s.  If I type a character
> (doesn't seem to matter what), instead of that character printing I see
> the next character of console output.  I have to hold down a key for a
> few seconds to get the next few lines of output, then it starts printing
> on its own again.  I've seen this with 2.6.7-rc3-bk4 and 2.6.6, not with
> 2.6.5 (I booted 2.6.6 by accident yesterday, I don't know how it does
> with NFS).

More experience with 2.6.7-rc3-bk6: this is basically the same, although
the console stalled twice during one boot, once after mounting all the
filesystems and then again after the ethernet comes up (as always).

Also, I was wrong about getting one character of output for each that I
type - it looks like I get 16 characters (if that many are available to
be printed, seemingly).

-ryan
