Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272771AbTG3Fpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272773AbTG3Fpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:45:51 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:23059 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272771AbTG3Fpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:45:47 -0400
Date: Tue, 29 Jul 2003 22:45:43 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030730054543.GG9836@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <buollugep3u.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buollugep3u.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause drowsiness.  Do not operate heavy machinery.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 11:16:05AM +0900, Miles Bader wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > No. There are no ANSI, nor DEC nor AT&T nor IRIS, nor IBM, nor any
> > other terminals that have screen-blanking capabilities.
> 
> Yes there are.  I guess you never used any of them.
> 
> [The brand that immediately comes to mind is Wyse, but I seem to recall
> the H29 having this capability too...]

I can't speak for the others but according to my Wyse 50
manual the S.SAVER feature in the field level 4 menu
has a default value of OFF.

My recollection is that this was common among the VDTs which
suffered considerably from burn-in.  Many of the later
models had the feature but it was a hardware setting
controlled via a configuration menu or a dip-switch.  You
want the setting to persist across logins and power cycling.

It really should be disabled in-kernel by default.  The
distribution RC scripts would as a default then enable it
late in the boot process.  In a server setting where it
isn't wanted the admin should know enough to prevent its
being enabled.

I too have been bitten by this on servers where the console
display is either powered down or disconnected for months at
a time.  The error messages leading to the hang may be in
the display buffer but they can't be seen.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
