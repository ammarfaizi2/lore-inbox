Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVDWSCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVDWSCa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVDWSCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:02:30 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:14030 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261640AbVDWSCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:02:25 -0400
Date: Sat, 23 Apr 2005 19:54:22 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
Message-ID: <20050423175422.GA7100@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there is no need to tell the verifier against what key to verify because
the signature already contains this information.

> If somebody writes a script to generate the above kind of thing (and
> tells me how to validate it), I'll do the rest, and start tagging
> things properly. Oh, and make sure the above sounds sane (ie if
> somebody has a better idea for how to more easily identify how to find
> the public key to check against, please speak up).

# This creates the signature.
gpg --clearsign < sign_this > signature

# And this verifies it. 
gpg --verify < signature && echo valid

	Thomas
