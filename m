Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbTD3TTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTD3TTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:19:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:34944 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262374AbTD3TTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:19:22 -0400
Date: Wed, 30 Apr 2003 20:31:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Gabriel Paubert <paubert@iram.es>, Andi Kleen <ak@suse.de>,
       joe briggs <jbriggs@briggsmedia.com>, linux-kernel@vger.kernel.org
Subject: Re: software reset
Message-ID: <20030430193138.GA15981@mail.jlokier.co.uk>
References: <200304291037.13598.jbriggs@briggsmedia.com.suse.lists.linux.kernel> <p73vfwx2uw8.fsf@oldwotan.suse.de> <20030430075004.GB13859@mail.jlokier.co.uk> <m1llxsfdpg.fsf@frodo.biederman.org> <20030430161525.GA3834@iram.es> <m1he8fgbpq.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1he8fgbpq.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> > On Wed, Apr 30, 2003 at 05:04:59AM -0600, Eric W. Biederman wrote:
> > > 
> > > And as an interesting data point all a triple fault does on a modern
> > > system is to put the cpu in a weird stopped state.  Some hardware
> > > usually the southbridge then detects this and if properly configured
> > > will trigger the reset line.
> > > 
> > > I believe this may actually go back into history as far as the 486 but
> > > I have not done the researched to see how far back this behavior goes.
> > 
> > Try 286. It was the fastest (actually only) way to make a 286 switch back
> > from protected to real mode.
> 
> A triple fault would put a 286 into coma mode?  And the hardware had to
> reset the chip?

And then, after the reset, a flag would tell the BIOS to jump directly
to application's real mode code instead of booting as usual.

-- Jamie
