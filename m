Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbTIKVi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTIKVi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:38:27 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:36107 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261541AbTIKViZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:38:25 -0400
Date: Thu, 11 Sep 2003 23:38:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: =?iso-8859-1?Q?G=E1bor_L=E9n=E1rt?= <lgb@lgb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: horrible usb keyboard bug with latest tests
Message-ID: <20030911233823.A2383@pclin040.win.tue.nl>
References: <20030911125744.89506.qmail@web60207.mail.yahoo.com> <20030911134608.GN15818@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030911134608.GN15818@vega.digitel2002.hu>; from lgb@lgb.hu on Thu, Sep 11, 2003 at 03:46:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 03:46:08PM +0200, Gábor Lénárt wrote:
> On Thu, Sep 11, 2003 at 05:57:44AM -0700, Mr. Mailing List wrote:
> > Ok, for the last few test kernels, there is a horribly
> > annoying usb keyboard bug.  after a while in X, or
> > just when you start putting some input, all the
> > keyboard lights on on my msnatpro keyboard.  after
> > that, the keycodes  are screwed up(like the left alt
> > button)
> > 
> > sometimes one key would stick, like
> > kkkkkkkkkkkkkkkkkkkkkkkkkk
> 
> For me too, even with a normal keyboard attached to the PS/2 keyboard port.
> In my case it's very rare, and not a 'constant stick' but short 'pulse' of
> the same character like displaying 'kkkkkkkkk' in my terminal even if I'm
> sure that I didn't forget my finger on the key. OK, it's not a showstopper
> bug, but sometimes annoying. It's 2.6.0-test3 (vanilla).

Yes, I see this too, but very infrequently.

For the 2.6 kernels key repeat is not taken from the keyboard but is
done via a kernel timer, and clearly the code is not quite correct.
I have not yet been able to detect it before I already
had hit the next key but maybe somebody else can answer:

When does this repeat stop?
Does it stop because the next key has been hit?

And: does it occur more often when the machine has high load?

Andries

