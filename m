Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTIKWkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTIKWkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:40:21 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:5644 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261588AbTIKWkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:40:16 -0400
Date: Fri, 12 Sep 2003 00:40:15 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Mr. Mailing List" <mailinglistaddie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: horrible usb keyboard bug with latest tests
Message-ID: <20030912004015.B2383@pclin040.win.tue.nl>
References: <20030911125744.89506.qmail@web60207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030911125744.89506.qmail@web60207.mail.yahoo.com>; from mailinglistaddie@yahoo.com on Thu, Sep 11, 2003 at 05:57:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 05:57:44AM -0700, Mr. Mailing List wrote:

> Ok, for the last few test kernels, there is a horribly
> annoying usb keyboard bug.  after a while in X, or
> just when you start putting some input, all the
> keyboard lights on on my msnatpro keyboard.  after
> that, the keycodes  are screwed up(like the left alt
> button)
> 
> sometimes one key would stick, like
> kkkkkkkkkkkkkkkkkkkkkkkkkk
> 
> now with test 5, the keyboard seems to stop responding
> completely
> 
> the only fix is to unplug/replug keyboard
> 
> help?

# All the keyboard lights.
That probably means that your keyboard did a reset.

# the keycodes are screwed up (like the left alt button)
Most keys are still OK but a few, like left alt, have become bad?

# now with test 5, the keyboard seems to stop responding completely
Do you mean it doesnt work at boot time?
Or do you mean that you work for a while, a reset happens,
and after that the keyboard is dead?

# kkkkkkkkkkkkkkkkkkkkkkkkkk
I asked elsewhere - let me repeat the question:
does this repeat stop (only) when you hit the next key?

Andries



