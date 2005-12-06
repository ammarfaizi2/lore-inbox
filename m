Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbVLFOua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbVLFOua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbVLFOu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:50:29 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58470
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751669AbVLFOu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:50:29 -0500
Date: Tue, 6 Dec 2005 15:50:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>, Tim Bird <tim.bird@am.sony.com>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206145025.GY28539@opteron.random>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206005341.GN28539@opteron.random> <4394E750.8020205@am.sony.com> <1133861208.10158.34.camel@tara.firmix.at> <1133863003.4136.42.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133863003.4136.42.camel@baythorne.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 09:56:43AM +0000, David Woodhouse wrote:
> [..] we might as well be
> using it for all symbols [..]

Cool, so if we use it for all symbols it will add zero information to
the kernel. Which means it's exactly the same as if we nuke _GPL tag
completely and we remove it from all symbols.

I always thought the _GPL tag isn't needed and can be removed, your
suggestion to add it to all symbols confirms it. Furthermore its
existence is a sort of proof that you can legally link the kernel with
non-GPL modules (which Greg disagrees with, I don't have an opinion, I
only know Linus said binary only drivers are ok as long as they don't
create a derivative of the kernel).

I don't think the GPL tag can make somebody more or less illegal, it's
just irrelevant. This is just a favour we make to those companies, and
that they may also not trust in the first place because we're not
lawyers in the first place.

> By switching in the opposite direction, Linus is actively weakening our
> position, and I object very strongly to that.

I think Linus is doing the right thing here, and he is avoiding what I
described in the previous email: that is breaking drivers gratuitously
is what could make linux hostile and too costly to support IMHO. We want
to be parnters with all hardware companies, but we want them to support
linux properly (not with binary only drivers), in a way that we can fix
it, port it to other archs, and so that we don't lose support for the
hardware while improving internal APIs.

Also note, that if we lose control on the development (the doomsday
scenario) everybody else loses control too, it's not like somebody can
bank on it and steal the control and profit from it and pay lots of
taxes to the US governament. Everybody will lose and wealth will be
destroyed globally and less taxes will be paid in all countries
worldwide. All those hardware companies compete against each other, so
each one will have control on a little tiny piece of the OS, so when a
bug triggers in the doomsday secnario, the thing will become
undebuggable for everyone (at best everyone can blame on each other when
there's random memory corruption). That again may be acceptable for a
desktop, but I doubt it's acceptable for servers.
