Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWE1VYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWE1VYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWE1VYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:24:03 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:43236 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750890AbWE1VYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:24:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Paul Dickson <paul@permanentmail.com>
Subject: Re: Bisects that are neither good nor bad
Date: Sun, 28 May 2006 23:24:12 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060528140238.2c25a805.dickson@permanentmail.com> <20060528140854.34ddec2a.paul@permanentmail.com>
In-Reply-To: <20060528140854.34ddec2a.paul@permanentmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605282324.13431.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 23:08, Paul Dickson wrote:
> On Sun, 28 May 2006 14:02:38 -0700, Paul Dickson wrote:
> 
> > Building and testing a good kernel takes me about 70 minutes.  If I make
> > mistakes it can easily take two times (or more!) longer.
> >
> > I'm currently tracking my work at:
> >     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185108
> >
> > I'm currently building my fifth bisect.

Could you please also try if the problems persist if you boot with
init=/bin/bash?

Besides, it would be helpful if you were able to get a serial console log
from the failing system.

> Is there a method of bisecting that means neither "good" nor "bad"?  I
> have run into kernel problems that are not related to the problem I'm
> attempting to track.  Some are not avoidable by changing the .config (see
> the third bisect in comments 10 and 11 in the bugzilla report).

There are lots of patches between 2.6.16-rc* and 2.6.17-rc1, most of them
having stayed in -mm for some time.  If you found the first failing -mm kernel,
it would be easier to catch the offending patch.

BTW, have you tried any kernel _after_ 2.6.17-rc1?  If not, I'd start from
these.

Greetings,
Rafael
