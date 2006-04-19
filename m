Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWDSLBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWDSLBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 07:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDSLBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 07:01:13 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:4704 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750721AbWDSLBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 07:01:13 -0400
Message-ID: <44461BAB.9080301@gentoo.org>
Date: Wed, 19 Apr 2006 12:14:51 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: Trond Myklebust <Trond.Myklebust@netapp.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       okir@monad.swb.de
Subject: Re: [PATCH] sunrpc svc: be quieter
References: <20060305005532.5E7A0870504@zog.reactivated.net>	 <Pine.LNX.4.61.0603051451590.30115@yvahk01.tjqt.qr>	 <1141678330.31680.13.camel@lade.trondhjem.org>	 <441733C0.5040605@gentoo.org> <1142371759.7987.27.camel@lade.trondhjem.org>
In-Reply-To: <1142371759.7987.27.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> I can't see that authorising calls to prog==0 could ever be useful (what
> would that mean?), but proc==0 is another matter: that is precisely the
> NULL procedure call that I mentioned above.

Just to let you know, I did cook up a patch but the user has gone 
unresponsive (it's an important production server so finding downtime is 
hard).

Here is the patch if you are interested: 
http://bugs.gentoo.org/attachment.cgi?id=82195&action=view

If/when he responds, I'll remove the 2nd hunk and submit the patch properly.

Thanks,
Daniel
