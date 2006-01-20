Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWATOsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWATOsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWATOsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:48:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51415 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751037AbWATOsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:48:21 -0500
Date: Fri, 20 Jan 2006 15:47:53 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Lee Revell <rlrevell@joe-job.com>, marc@perkel.com, arjan@infradead.org,
       mail@earthworm.de, linux-kernel@vger.kernel.org
Subject: Re: So - What's going on with Reiser 4?
In-Reply-To: <20060120040023.310a1ea8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0601201545290.22940@yvahk01.tjqt.qr>
References: <43C837B6.5070903@perkel.com> <1137236892.3014.12.camel@laptopd505.fenrus.org>
 <200601141322.34520.mail@earthworm.de> <1137242691.3014.16.camel@laptopd505.fenrus.org>
 <43C99491.3080907@perkel.com> <1137293454.19972.6.camel@mindpipe>
 <43C9C042.5090000@perkel.com> <1137299139.25801.7.camel@mindpipe>
 <20060120040023.310a1ea8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Arjan was just telling
>>  you that it's not up to the kernel developers when reiser4 gets in
>
>Well it is a bit.  Current status is that we just don't have anyone who's
>sufficiently familar with VFS internals and idioms who has the
>time+inclination to sit down and work with the reiserfs developers to get
>the thing into a generally-acceptable state.  Progress has been made over
>the past 12-28 months, but there's more to do.  It's a huge piece of code
>and a lot of work to do this.
>[...]
>So reiser4 is somewhat in a state of limbo at present.  We need to
>generally up the tempo and firm up some plans rather than letting things
>drift like this, but I don't see a way in which we can do that.

Yep, http://kerneltrap.org/node/5654 suggests [to me] that the repacker be 
finished first before it's of good use

  "Hans Reiser: Our fsync performance is not optimized yet, and will be bad 
  until it is optimized. Our performance for fully random modifications 
  will be bad until we ship a repacker." (kerneltrap article from September 
  13 2005)


Jan Engelhardt
-- 
