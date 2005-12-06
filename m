Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVLFRYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVLFRYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVLFRYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:24:55 -0500
Received: from kanga.kvack.org ([66.96.29.28]:44686 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932457AbVLFRYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:24:55 -0500
Date: Tue, 6 Dec 2005 12:21:53 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Michael Poole <mdpoole@troilus.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206172153.GB22502@kvack.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206041215.GC26602@kroah.com> <87iru2c0zc.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iru2c0zc.fsf@graviton.dyn.troilus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 11:18:15PM -0500, Michael Poole wrote:
> Besides, if the act of linking is what makes the derivative work,
> there is no problem: The GPL allows a user to make any modifications
> or combinations or derivatives whatsoever, and only imposes
> requirements when the result is distributed.  The linking of the two
> works occurs only on the end user's machine.

But if it's a module, it's probably been compiled against kernel headers.  
Last time I checked, header files were covered by the GPL unless explicitly 
placed under a more permissive license.  How do you use something like 
spinlocks without compiling in GPL code to a module?

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
