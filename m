Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272780AbTG3GDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272783AbTG3GDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:03:43 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:24851 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272780AbTG3GDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:03:41 -0400
Date: Tue, 29 Jul 2003 23:03:37 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030730060337.GH9836@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause drowsiness.  Do not operate heavy machinery.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 08:17:15PM -0400, Zwane Mwaikambo wrote:
> On Tue, 29 Jul 2003, Richard B. Johnson wrote:
> 
> > If the machine had blanking disabled by default, then the
> > usual SYS-V startup scripts could execute setterm to enable
> > it IFF it was wanted.
> 
> optimise for the common case, just fix your box and be done with it.

To borrow from the medical community: "First, do no harm."

There is harm in having blanking enabled during the boot
sequence as well as later.  There is very little harm in no
screen blanking at all.  There is no harm in deferring the
entablement of screen blanking until some time in the RC
scripts where it can be prevented by those who know better.

There is no need for auto-blanking to be a boot parameter if
it defaults to off.  Boot parameters are the least optimal
treatment of this issue.

The common case of which you speak is the least optimised
environment you're likely to find.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
