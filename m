Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVFURgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVFURgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVFURgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:36:35 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60836 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262208AbVFURgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:36:10 -0400
Subject: Re: IBM HDAPS Someone interested?
From: Lee Revell <rlrevell@joe-job.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Adam Goode <adam@evdebs.org>, Pavel Machek <pavel@suse.cz>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
In-Reply-To: <20050621164519.GA11601@ucw.cz>
References: <20050620155720.GA22535@ucw.cz>
	 <005401c575b3_5f5bba90_600cc60a@amer.sykes.com>
	 <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz>
	 <20050620204533.GA9520@ucw.cz>
	 <1119303016.5194.24.camel@lynx.auton.cs.cmu.edu>
	 <1119368259.19357.18.camel@mindpipe>  <20050621164519.GA11601@ucw.cz>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 13:36:03 -0400
Message-Id: <1119375363.4569.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 18:45 +0200, Vojtech Pavlik wrote:
> On Tue, Jun 21, 2005 at 11:37:38AM -0400, Lee Revell wrote:
> > Ugh, if userspace can't meet a 300ms RT constraint, that's a pretty
> > shitty OS you have there.
> 
> It's not that you do one measurement in the 300ms. You need to do at least
> 100, and some computations, too.
> 
> > This should certainly be done in userspace on Linux.
> 
> So it's a 3ms RT constraint, which is not as easy.
> 

Heh, we do it all the time with JACK.

But, I think I was wrong anyway, you'll have to do it in the kernel
because you would need PREEMPT to meet that with any degree of
certainty.

Lee

