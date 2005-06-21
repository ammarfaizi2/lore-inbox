Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVFUQsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVFUQsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVFUQrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:47:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:48106 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262171AbVFUQpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:45:11 -0400
Date: Tue, 21 Jun 2005 18:45:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adam Goode <adam@evdebs.org>, Pavel Machek <pavel@suse.cz>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
Message-ID: <20050621164519.GA11601@ucw.cz>
References: <20050620155720.GA22535@ucw.cz> <005401c575b3_5f5bba90_600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz> <20050620204533.GA9520@ucw.cz> <1119303016.5194.24.camel@lynx.auton.cs.cmu.edu> <1119368259.19357.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119368259.19357.18.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 11:37:38AM -0400, Lee Revell wrote:

> On Mon, 2005-06-20 at 17:30 -0400, Adam Goode wrote:
> > Freefall detection: 300 ms
> > Head park time: 300-500 ms
> >   (from page 2 of document)
> > 
> > Still doesn't seem too bad to figure out how to code though, at least
> > once we can figure out how to get the data stream!
> > 
> > P.S. The main control system runs as a Windows kernel driver. Not as
> > safe as full hardware, but probably better than userspace. :)
> > 
> 
> Ugh, if userspace can't meet a 300ms RT constraint, that's a pretty
> shitty OS you have there.

It's not that you do one measurement in the 300ms. You need to do at least
100, and some computations, too.

> This should certainly be done in userspace on Linux.

So it's a 3ms RT constraint, which is not as easy.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
