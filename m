Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTHUP3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTHUP3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:29:43 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:56258 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262740AbTHUP3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:29:40 -0400
Date: Thu, 21 Aug 2003 17:29:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Jamie Lokier <jamie@shareable.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821152922.GA25936@ucw.cz>
References: <20030821164435.B3518@pclin040.win.tue.nl> <Pine.GSO.3.96.1030821164926.2489M-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030821164926.2489M-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 05:03:33PM +0200, Maciej W. Rozycki wrote:

>  I meant: how does the translation work if there is only a single onboard
> controller that does scanning of the embedded keyboard and presents set #1
> of codes directly?  But after a bit of thinking I suppose it does support
> translation for an external keyboard (which presents set #2 by default and
> a lot of PC software expects set #1) and probably a pass-through mode for
> it as well. 
> 
>  What the big fault of all these limited implementations is, there is no
> reliable way to query what is supported.  If a device does not support
> mode switching or a particular mode, it should NAK a command that does it,
> or at least report the original mode if queried afterwards.

Most do, most do ...

> Another
> possibility is to return a different device ID -- IBM chose a single value
> of 256 possible for its PS/2 keyboards -- why couldn't the incompatible
> others have chosen something different, sigh?... 

Some do ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
