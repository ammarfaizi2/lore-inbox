Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131542AbQLIWfh>; Sat, 9 Dec 2000 17:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132343AbQLIWf1>; Sat, 9 Dec 2000 17:35:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2056 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131542AbQLIWfN>; Sat, 9 Dec 2000 17:35:13 -0500
Date: Sat, 9 Dec 2000 16:00:27 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Bob Lorenzini <hwm@ns.newportharbornet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
Message-ID: <20001209160027.A15007@vger.timpanogas.org>
In-Reply-To: <20001209154916.A14937@vger.timpanogas.org> <Pine.LNX.4.21.0012091400590.17164-100000@newportharbornet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0012091400590.17164-100000@newportharbornet.com>; from hwm@ns.newportharbornet.com on Sat, Dec 09, 2000 at 02:03:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 02:03:08PM -0800, Bob Lorenzini wrote:
> On Sat, 9 Dec 2000, Jeff V. Merkey wrote:
> 
> > 
> > 
> > 2.2.18-25 with Frame Buffer enabled will frizt and trash LCD displays
> > on DELL laptop computers when the system kicks into graphics mode,
> > and attempts to display the penguin images on the screen.  It 
> > renders the anaconda installer dead in the water when you attempt 
> > even a text mode install (not graphics) of a 2.2.18-25 kernel (and 24)
> > on a DELL laptop.  Is there a way to turn on frame buffer without 
> > kicking the kernel into mode 274 and killing DELL laptops during
> > a text based install?
> 
> Jeff the change that broke or first broke is in 2.2.17-15 if thats any help.
> 
> Bob

Alan,

Id there a workaround for this for DELL laptops.  Frame buffer needs
to be enabled because you don't really know what system you are on
until after it installs, and the X probing stuff needs it enabled in
order to properly detect the hardware.  Any ideas?

:-)

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
