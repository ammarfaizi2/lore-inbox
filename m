Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTLEJaC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 04:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTLEJaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 04:30:02 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:10918
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S263269AbTLEJaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 04:30:00 -0500
Date: Fri, 5 Dec 2003 01:32:00 -0800
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Double-click on touchpad
Message-ID: <20031205093200.GA8877@nasledov.com>
References: <1070610304.4328.14.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070610304.4328.14.camel@idefix.homelinux.org>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have both /dev/psaux and /dev/input/mice in your XF86Config file? In
2.6, these are the same thing, so it actually opens the same mouse twice and
it can cause such weird issues with it.

On Fri, Dec 05, 2003 at 02:45:04AM -0500, Jean-Marc Valin wrote:
> I'm running 2.6.0-test11 on a Dell Latitude D600 laptop and I'm having
> some problems with the touchpad. For some reason, if I hit the touchpad
> twice, the driver seems to generate a triple-click instead of a double
> click. However, clicking on the actual button twice correctly generates
> a double-click. I checked and 2.4 behaves correctly. Is that a bug or
> did something just changed in the way the mouse is handled.
> 
> 	Jean-Marc
> 
> P.S. I'm not subscribed to the list

-- 
Misha Nasledov
misha@nasledov.com
