Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUASUnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUASUnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:43:55 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:21635 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263592AbUASUny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:43:54 -0500
Date: Mon, 19 Jan 2004 21:43:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: fire-eyes <sgtphou@fire-eyes.dynup.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: atkbd.c errors + mouse errors with a belkin KVM
Message-ID: <20040119204348.GA2251@ucw.cz>
References: <400C1D2F.7020503@fire-eyes.dynup.net> <20040119202905.A1073@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119202905.A1073@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 08:29:05PM +0100, Andries Brouwer wrote:
> On Mon, Jan 19, 2004 at 01:08:47PM -0500, fire-eyes wrote:
> 
> > I'm seeing some strange behavior using kernel 2.6.1 and a Belkin KVM.
> > ... I often get the following error:
> > 
> > kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> > isa0060/serio0).
> 
> It is not really an error - the kernel is just being a bit noisy.
> The 0x7a was really 0xfa, the ACK that a keyboard command succeeded.
> 
> Sooner or later the noise will go away. For now it is more interesting
> to fix bugs in behaviour.

Well, the kernel is quite rightfully noisy at this point - getting
unexpected ACKs is rather suspicious.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
