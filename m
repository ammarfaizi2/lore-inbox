Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTJLLIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTJLLIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:08:51 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:55306 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263445AbTJLLIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:08:49 -0400
Date: Sun, 12 Oct 2003 13:08:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Michael Hunold <hunold@convergence.de>, shemminger@osdl.org,
       linux-dvb@linuxtv.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/14] LinuxTV.org DVB driver update
Message-ID: <20031012110846.GA1677@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	"David S. Miller" <davem@redhat.com>,
	Michael Hunold <hunold@convergence.de>, shemminger@osdl.org,
	linux-dvb@linuxtv.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20031011105320.1c9d46db.davem@redhat.com> <Pine.GSO.4.21.0310121115260.27309-100000@starflower.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310121115260.27309-100000@starflower.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 11:16:03AM +0200, Geert Uytterhoeven wrote:
> On Sat, 11 Oct 2003, David S. Miller wrote:
> > On Sat, 11 Oct 2003 10:41:43 +0200
> > Michael Hunold <hunold@convergence.de> wrote:
> > 
> > > Unfortunately, I don't notice every patch that goes directly into 2.6 
> > > without getting postet on the linux-dvb mailinglist. Now if someone 
> > > changes stuff in our CVS in the same file, it can happen that the stuff 
> > > from the kernel is wiped out.
> > 
> > It is your responsibility to resolve such things though.  It is
> > inevitable and unavoidable that others outside of your development
> > group will make many changes to your files, as we fix bugs that
> > are tree-wide.
> 
> So you best subscribe to bk-commits-head and monitor every patch that affects
> drivers/media/dvb/.

Or more simple - keep a copy of the kernel where your patches got applied,
and make a diff between that kernel and latest.
Apply that diff to your local tree, and you are up-to-date.

This gives a good opportunity to review what has been applied without
passing the maintainer.

And finally it also resolve potential conflicts.

And as always - the more frequent you get patches applied, the less burden
it is to update to latest kernel.

	Sam
