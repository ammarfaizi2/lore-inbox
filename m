Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbVKDPKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbVKDPKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbVKDPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:10:32 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:61572 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932737AbVKDPKa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:10:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uZGNl9Q1J35oxQqDymZPwvj/IfX5P5gSI0YYU52fQd7tgAfly4TdFkUAloF/OdE1ad7sxoPfq0Fr4F5oOZ6gwxlvm/iXLljrIpkkuJ5HjmQo8EE+71w359Ohh1Lx7IaAfoFrlX9DPj7MGS7uHH8oh4l8Y0WTdkkDxe7ftkPeiRs=
Message-ID: <5bdc1c8b0511040710q4a4ce3eend6edc2b4027e33b0@mail.gmail.com>
Date: Fri, 4 Nov 2005 07:10:27 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3D video card recommendations
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1131112605.14381.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131112605.14381.34.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> I'm currently putting together (ordering parts for) another machine. It
> will be a AMD64 X2. Now I'm looking into a video card for this.  Up till
> now, I've always used NVidia.  But I also want to test 3D acceleration
> under Ingo's -rt patch.  So now I need something that does not have a
> priority module.
>
> I'm not much of a gamer, although I do play every so often. So I don't
> need the highest quality card, but I also want something that is still
> pretty good. For example, I currently have a NVidia GeForce 6800 GT
> card.  So I'm hoping to get something equivalent.
>
> I'm looking at the ATI Radeons.
>
> Any recommendations? (links to info would also be nice ;-)
>
> Thanks,
>
> -- Steve

Not a recommendation. Just a point to be aware of. The ATI Radeons, to
get the best acceleration, seem to require that you use the ATI closed
source drivers. Currently I haven't found an ATI closed source driver
that supports 2.6.14. so I'm forced to use the Xorg radeon driver. I
have no idea if this is very good. I don't think so as my glxgear
numbers are pretty low. Much lower than the ATI driver running on
2.6.13-X.

NOTE: I'm horrible at setting up all the 3D stuff as I don't
understand what to chose and what to avoid. This could be far better
than the results I get!

- Mark
