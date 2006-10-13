Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWJMQHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWJMQHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWJMQHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:07:49 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:31896 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751258AbWJMQHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:07:48 -0400
Message-ID: <1160755665.452fb9d128a2b@imp5-g19.free.fr>
Date: Fri, 13 Oct 2006 18:07:45 +0200
From: neologix@free.fr
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] ATI IXP - Unknown symbol -> no sound
References: <1160751687.452faa4742f00@imp5-g19.free.fr> <1160754364.4201.1.camel@mindpipe>
In-Reply-To: <1160754364.4201.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 70.225.171.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
Thanks for your reply, but it can't be this, because I build my own kernel.
I tried with vanilla kernel, and Debian's one, but I'm still experiencing these
problems. What's weird is that this doesn't happen everytime, maye one out of
5, or something, and I never had these kind of problems with <= 2.6.15

Well, I could just not use modules, but I'd like to know what's going wrong, and
if it's a kernel bug, have it spotted and hopefully fixed.

cheers


Selon Lee Revell <rlrevell@joe-job.com>:

> On Fri, 2006-10-13 at 17:01 +0200, neologix@free.fr wrote:
> > Hello.
> >
> > short:
> > [2.6.18] ATI IXP - Unknown symbol -> no sound
> >
> > longer:
> > I have an ATI IXP sound card, and since kernel 2.6.17, sometimes I have no
> sound
> > when I boot.
> > The card dosn't appear in /proc/asound/cards
> >
> > The relevant log part are given below
> > What is weird is that the modules are loaded, and that it doesn't happen
> > everytime.
> > I have a P4 with hyperthreading enabled (I don't know if it plays a part).
> > The thing is that before 2.6.17, I never had problems
>
> Sounds like your ALSA modules were built against a different kernel.
>
> Lee
>
>


