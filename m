Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUBAIV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 03:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUBAIV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 03:21:26 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:36224 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265231AbUBAIVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 03:21:25 -0500
Date: Sun, 1 Feb 2004 09:21:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 Speaker
Message-ID: <20040201082143.GB287@ucw.cz>
References: <20040131022540.04278a4a.backblue@netcabo.pt> <20040131081439.GA440@ucw.cz> <20040201013136.GA16043@fubini.pci.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201013136.GA16043@fubini.pci.uni-heidelberg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 02:31:36AM +0100, Bernd Schubert wrote:

> On Sat, Jan 31, 2004 at 09:14:39AM +0100, Vojtech Pavlik wrote:
> > On Sat, Jan 31, 2004 at 02:25:40AM +0000, backblue wrote:
> > 
> > > I'm using 2.6.1 kernel, and my speakers stop's working with 2.6.1,
> > > anyone know why? this dont append to me, a couple of friends have the
> > > same problem, how can i solve this... 
> > 
> > You need to enable it. Drivers->Input->Misc->PC-Speaker
> >
> 
> I was wondering myself why I didn't get any speaker-output, so this is
> the solution. However, I'm wondering why this is a sub-option of Input
> and not of Sound?

Because it's an device that registers with the input (console)
subsystem, and not with the sound (alsa/oss) subsystem. It's a beeper,
not a sound card.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
