Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTDXNFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTDXNFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:05:22 -0400
Received: from almesberger.net ([63.105.73.239]:50952 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261866AbTDXNFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:05:20 -0400
Date: Thu, 24 Apr 2003 10:16:49 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jamie Lokier <jamie@shareable.org>, Matthias Schniedermeyer <ms@citd.de>,
       Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424101649.K3557@almesberger.net>
References: <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <29360000.1051159644@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29360000.1051159644@[10.10.2.4]>; from mbligh@aracnet.com on Wed, Apr 23, 2003 at 09:47:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Not sure what you mean. Load kernel, load xmms. hit play. Sound comes out.
> Goodness.

Well, replace "load kernel" with "boot system", and we're in violent
agreement :-)

> So we can fix it in userspace, and decided a sensible non-zero default
> there, but are somehow incapable of doing that *inside* the kernel? Sorry,
> I don't buy that. 

No, you still have to make a guess, but you don't need to involve
the kernel. (I think Redmond owns most of the intellectual property
on "if you don't know where to put it, put it in the kernel, for it
will be faster and more secure that way", so we shouldn't use this
paradigm too often :-)

Since choosing this default is something between the distribution
maker and the user, they can

 - choose to leave it silent ("expert mode")
 - perhaps use other information they've gathered at install time
 - reuse old stored settings (e.g. look for an aumixrc)
 - pop up a dialog
 - print a warning
etc.

> The old "document the bugs" arguement.

;-) True, but in this case, you're very likely to run into problems
if you don't religiously follow Documentation/Changes anyway. And
there are people I fully expect to read this line by line - namely
the distribution makers. And they're exactly the ones who need to
be aware of this issue.

> Bugs should be fixed, not documented.

It's a feature :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
