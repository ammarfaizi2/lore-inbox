Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266414AbUFQIgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266414AbUFQIgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266416AbUFQIgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:36:55 -0400
Received: from tor.morecom.no ([64.28.24.90]:53386 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S266414AbUFQIgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:36:54 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Petter Larsen <pla@morecom.no>
To: Eugene Crosser <crosser@rol.ru>
Cc: ext3 <ext3-users@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1087323602.16701.42.camel@ariel.sovam.com>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	 <1087322976.1874.36.camel@pla.lokal.lan>
	 <1087323602.16701.42.camel@ariel.sovam.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087461413.2765.42.camel@pla.lokal.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 17 Jun 2004 10:36:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Data integrity is much more important for us than speed.
> 
> I ran ext3 with data=journal on 2.6.6smp for about a week on a heavily
> loaded system (I mean it).  I did not ever experience filesystem
> corruption (related to the fs code).  I did, however, hit complete
> system lockup once.  It *may* have been unrelated to the fs code.
> 
> (If you use quota, it *will* lock.  The author is working on a fix.
> Above, I am referring to a lockup with quota off).
> 
> Eugene

Good to here. But there may have been a lookup once because you are not
sure that the crash was unrelated to ext3 fs code?

Are you going to test it more?

We are not going to use quota, we are using ext3 on a compact flash disk
in an embedded device.


-- 
Petter Larsen
cand. scient.
moreCom as
913 17 222
