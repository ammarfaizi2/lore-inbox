Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVDXEiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVDXEiU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 00:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVDXEiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 00:38:20 -0400
Received: from quechua.inka.de ([193.197.184.2]:30175 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262247AbVDXEiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 00:38:19 -0400
Date: Sun, 24 Apr 2005 06:38:13 +0200
From: Bernd Eckenfels <be-mail2005@lina.inka.de>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-ID: <20050424043813.GA2422@lina.inka.de>
References: <20050423174227.51360d63.pj@sgi.com> <E1DPVwN-0007pj-00@calista.eckenfels.6bone.ka-ip.net> <20050423211326.7ed8e199.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423211326.7ed8e199.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 09:13:26PM -0700, Paul Jackson wrote:
> I don't believe you.  Reference?

I had MD5 in mind, sorry. I havent seen the SHA-1 colision samples, yet.
However it is likely to be available soon. (a simple pair with two files
will be enugh to cause "theoretical" problems. However I think it would be
possible to detect collisions on add and append sequence numbers... ugly.

> > Or at least go with FIPS 180-2.
> 
> FIPS 180-2 specifies four secure hash algorithms - SHA-1, SHA-256, 
> SHA-384, and SHA-512.  We're using SHA-1.

Yes, I was referring to the longer versions (aka SHA-2), since FIPS tries to
phase out the 160bit version (till 2010).

Anyway I know we dont need to discuss this, I just wanted to point out that
in practical usage as source repository we might not see problems, but it
does not mean that there arent some already provokeable. PErsonally I see
the advantage of the "stateless" hash approach about more correct statefull
approaches like BK.

Greetings
Bernd

