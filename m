Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTIZIqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 04:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTIZIqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 04:46:44 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:641 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S262013AbTIZIqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 04:46:43 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Keyboard oddness.
Date: Fri, 26 Sep 2003 03:43:33 -0500
User-Agent: KMail/1.5
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200309201633.22414.rob@landley.net> <200309252027.57512.rob@landley.net> <20030926081542.GA21857@win.tue.nl>
In-Reply-To: <20030926081542.GA21857@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309260343.34434.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 September 2003 03:15, Andries Brouwer wrote:

> > You're talking about missed keypresses, but the end-user symptom I'm
> > seeing is definitely a missed key release
>
> Yes - here a release was garbled.
>
> Many people have reported missing key releases, and, as a consequence of
> that, stuck keys. Your reports feel a bit different: the e0 is sometimes
> lost from a key press, sometimes from a key release.

I don't know what to tell you.  When I compiled 2.4 (no detectable problems), 
I wasn't using the input (and in fact had it disabled).  Not necessarily a 
useful piece of information.  The symptom that I notice is software 
autorepeat going bananas when the hardware at least knows the key has been 
released and would not be sending hardware autorepeat events...

Rob
