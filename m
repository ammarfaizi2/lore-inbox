Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751938AbWISDqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbWISDqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 23:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWISDqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 23:46:05 -0400
Received: from web36610.mail.mud.yahoo.com ([209.191.85.27]:56479 "HELO
	web36610.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751945AbWISDqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 23:46:02 -0400
Message-ID: <20060919034601.97733.qmail@web36610.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Mon, 18 Sep 2006 20:46:01 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
To: Joshua Brindle <method@gentoo.org>
Cc: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <450F38F7.6080006@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Joshua Brindle <method@gentoo.org> wrote:


> > The first system I took through evaluation
> > (that is, independent 3rd party analysis) stored
> > security attributes in a file while the second
> > and third systems attached the attributes
> > directly (XFS). The 1st evaluation required
> > 5 years, the 2nd 1 year. It is possible that
> > I just got a lot smarter with age, but I
> > ascribe a significant amount of the improvement
> > to the direct association of the attributes
> > to the file.
> Thats great but entirely irrelevant in this context.
> The patch and caps 
> in question are not attached to the file via some
> externally observable 
> property (eg., xattr) but instead are embedded in
> the source code so 
> that it can drop caps at certain points during the
> execution or before 
> executing another app, thus unanalyzable.

Oh that. Sure, we used capability bracketing
in the code, too. That makes it easy to
determine when a capability is active. What,
you don't think that it's possible to analyze
source code? Of course it is. Refer to the
evaluation reports if you don't believe me.


Casey Schaufler
casey@schaufler-ca.com
