Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTLESFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTLESFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:05:38 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:20140
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S264319AbTLESFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:05:21 -0500
Date: Fri, 5 Dec 2003 10:07:21 -0800
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Double-click on touchpad
Message-ID: <20031205180721.GA1079@nasledov.com>
References: <1070610304.4328.14.camel@idefix.homelinux.org> <20031205093200.GA8877@nasledov.com> <1070637392.12400.1.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070637392.12400.1.camel@idefix.homelinux.org>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.6, this functions as both mice. However, if you go back to 2.4, you
will have to re-add the other entry to restore original functionality.

On Fri, Dec 05, 2003 at 10:16:33AM -0500, Jean-Marc Valin wrote:
> Le ven 05/12/2003 ? 04:32, Misha Nasledov a ?crit :
> > Do you have both /dev/psaux and /dev/input/mice in your XF86Config file? In
> > 2.6, these are the same thing, so it actually opens the same mouse twice and
> > it can cause such weird issues with it.
> 
> OK, I removed /dev/input/mice and it now behaves correctly. Now I'm just
> not sure how I can add a secondary USB mouse in these conditions...

-- 
Misha Nasledov
misha@nasledov.com
