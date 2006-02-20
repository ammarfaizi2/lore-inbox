Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbWBTUwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbWBTUwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbWBTUwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:52:04 -0500
Received: from mail.linicks.net ([217.204.244.146]:36320 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1161178AbWBTUwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:52:02 -0500
From: Nick Warne <nick@linicks.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: i386 AT keyboard LED question.
Date: Mon, 20 Feb 2006 20:51:51 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200602202003.26642.nick@linicks.net> <20060220202441.GB31272@suse.cz>
In-Reply-To: <20060220202441.GB31272@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202051.51882.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 20:24, Vojtech Pavlik wrote:
> On Mon, Feb 20, 2006 at 08:03:26PM +0000, Nick Warne wrote:
> > Hi Vojtech,
> >
> > I wondered why numlock LED goes off during boot process, even though I
> > ask BIOS to turn on;

~snip~

> Some old notebooks forget them on, which makes the keyboard unusable -
> you get '4' instead of 'u', etc.

Understand.  I never thought of that!

>
> We can't read the LED state anyway (except for going to the BIOS data
> structures, which isn't reasonable from the atkbd driver), and we need
> to initialize it, so off is the safer default.
>
> Further, this has been the behavior of Linux since it was first
> implemented, and thus, in my rewrite of the keyboard handling, I didn't
> change it.

Thanks for detailed reply - I see now, and didn't know any of this.

> It's trivial to change the default lock state in init scripts / xdm
> config / X config, too.

I boot into init 3, so as I don't reboot much, I always forget to turn numlock 
back on when logging in [failed] - hence the question.

I will look at a local fix rather than a patch for kernel.

Thanks again,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
