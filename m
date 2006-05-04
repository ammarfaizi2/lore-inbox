Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWEDJiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWEDJiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWEDJiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:38:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18703 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751461AbWEDJiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:38:22 -0400
Date: Thu, 4 May 2006 07:13:35 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <20060504071335.GA5359@ucw.cz>
References: <20060504024404.GA17818@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504024404.GA17818@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There are two messages in the input layer that seem to be
> triggerable very easily, and they confuse end-users to no end.
> "too many keys pressed? Should I press less keys?"
> I actually got a complaint from one user that he had only
> hit one key before being told to type less.

Actually, that message is useful for me. It tells me which keyboards
are crap; I have non-standard keymap (ctrl<->capslock) and some
keyboards can handle it while some other can't :-( (thinkpad x32
complains a bit). And yes, there is
problem hidden behind this message: if see this too often, your
keyboard will drop some keypresses, too (logitech keyboard with
touchpad).
					Pavel
-- 
Thanks, Sharp!
