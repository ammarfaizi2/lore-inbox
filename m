Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWEEKcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWEEKcD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 06:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWEEKcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 06:32:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53157 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750954AbWEEKcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 06:32:01 -0400
Date: Fri, 5 May 2006 12:31:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, dtor_core@ameritech.net,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <20060505103123.GB4206@elf.ucw.cz>
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz> <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com> <20060504183840.GE18962@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060504183840.GE18962@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 04-05-06 14:38:40, Dave Jones wrote:
> On Thu, May 04, 2006 at 02:34:34PM -0400, Dmitry Torokhov wrote:
> 
>  > >Perhaps it should say that then ;-)
>  > 
>  > Do you have a beter wording in mind? "Keyboard reports too many keys
>  > were pessed at once, some keystrokes might be dropped"?
> 
> It still doesn't make sense when the user only pressed a single key,
> or in some cases, never pressed *any* key (don't have that report to hand,
> but it was a laptop keyboard)

If you only pressed single key -- your keyboard is crap or there's
some problem in the driver.

If you never pressed any key -- your keyboard is crap or there's
some problem in the driver.

...in both of these cases the message is actually useful. Where it is
not useful is when cat walks over your keyboard, because you can
actually expect this message when pressing 10 keys at once.

...in both of these cases failure should be investigated to find out
what is going on.

OTOH for example I now know that capslock-x-c is combination X32 does
not like. Unfortunately, if you swap capslock and ctrl, and type too
fast... you'll press this combination while exiting emacs.

								Pavel
-- 
Thanks for all the (sleeping) penguins.
