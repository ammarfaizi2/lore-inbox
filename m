Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUAWHBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266551AbUAWG6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:58:52 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:16039 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266525AbUAWGzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:55:44 -0500
Date: Fri, 23 Jan 2004 06:54:10 +0000
From: Dave Jones <davej@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: logic error in radeonfb.
Message-ID: <20040123065410.GF9327@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <E1Ajuub-0000xr-00@hardwired> <1074840394.949.200.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074840394.949.200.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 05:46:35PM +1100, Benjamin Herrenschmidt wrote:
 > On Fri, 2004-01-23 at 17:35, davej@redhat.com wrote:
 > > Looks like another instance of a ! in the wrong place.
 > 
 > Ohh, and _oooold_ bug fixed a long time ago in 2.4. There may actually
 > be another occurence of this one elsewhere iirc. I'll check that.

Back then someone came up with a cool one-liner that grepped for
suspicious if's with !'s, it seems no-one ever did the same for 2.6,
as there were a few others (see seperate mails for patches).

 > that this code is powermac specific anyway and that old radeonfb doesn't
 > work very well on a lot of powermacs, so it's not very urgent. The new
 > radeonfb which has that fixed for a long time will get in along with
 > the fbdev updates as soon as I'm finished cleaning them up.

Ok, If this is going to make your merge more difficult, feel free to ignore it.

	Dave

