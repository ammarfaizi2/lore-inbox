Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUFJUih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUFJUih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUFJUih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:38:37 -0400
Received: from mail.stdbev.com ([63.161.72.3]:15799 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S263001AbUFJUie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:38:34 -0400
Message-ID: <efc4b1ba19898906eb0aec7ac9c22fcd@stdbev.com>
Date: Thu, 10 Jun 2004 15:46:24 -0500
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: Toshiba keyboard lockups
To: "Oleg Drokin" <green@linuxhacker.ru>
Reply-to: <jason@stdbev.com>
Cc: Fernando.Paredes@sun.com, linux-kernel@vger.kernel.org
In-Reply-To: <200406101915.i5AJFCBu197611@car.linuxhacker.ru>
References: <40A162BA.90407@sun.com>
            <200405121149.37334.rjwysocki@sisk.pl>
            <40C7880C.4000401@sun.com>
            <200406101915.i5AJFCBu197611@car.linuxhacker.ru>
X-Mailer: Hastymail 1.1-CVS
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2:15:12 pm 06/10/04 Oleg Drokin <green@linuxhacker.ru> wrote:
> Hello!
>
> Fernando Paredes <Fernando.Paredes@sun.com> wrote:
>
> FP> Applied these patches. Nothing while tail'ing /var/log/messages.
> Nothing FP> in the root console that I can see either.
> FP> Patched the source to 2.6.6. Still get the same lockups, totally
> random. FP> Any more ideas?
>
> Not sure if I have exact problem like you do, but at least I have
> something similar. Once in a while keyboard suddenly stopps working,
> touchpad still work though (I have Toshiba Satellite Pro (centrino
> based) laptop here). I figured out that if I leave the keyboard for
> some time (up to 2 minutes), it starts to work again, at least this
> was the case with XFree 4.4, during those no-keyboard times, mouse
> cursor was moving with small jumps (when keyboard works it moves
> smoothly). I upgraded to FC2 (and hence to xorg X server) today, and
> lockup happened once already, the "wait for some time" strategy did
> not work, so I remembered initially I thought this was something bad
> pressed on keyboard 

I have had similar issues with a toshiba laptop keyboard with 2.6+ kernels
for awhile. I have found that repeating the last key combination pressed
will "unlock" it. No logs or dmesg entries are produced when the lockup
occurs.

Its a Toshiba Satellite 1410-S173, currently running 2.6.7-rc2-mm2

\__ Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/


