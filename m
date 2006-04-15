Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWDOXHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWDOXHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWDOXHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:07:15 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:30409 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932515AbWDOXHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:07:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: jos poortvliet <jos@mijnkamer.nl>
Subject: Re: [ck] Re: [patch][rfc] quell interactive feeding frenzy
Date: Sun, 16 Apr 2006 09:06:57 +1000
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Al Boldi <a1426z@gawab.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
References: <200604112100.28725.kernel@kolivas.org> <200604151705.18786.kernel@kolivas.org> <200604160032.49845.jos@mijnkamer.nl>
In-Reply-To: <200604160032.49845.jos@mijnkamer.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604160906.57723.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 April 2006 08:32, jos poortvliet wrote:
> Op zaterdag 15 april 2006 09:05, schreef Con Kolivas:
> > Thanks for bringing this to my attention. A while back I had different
> > management of forked tasks and merged it with PF_NONSLEEP. Since then
> > I've changed the management of NONSLEEP tasks and didn't realise it had
> > adversely affected the accounting of forking tasks. This patch should
> > rectify it.
> >
> > Thanks!
>
> hey con, i get this:
>
> can't find file to patch at input line 9
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:

That's because it's not an attachment but inserted into the mail and your 
mailer is mangling it on extraction. Save the whole email unmodified (eg with 
a "save as" function) and use that as the patch. Don't fret as it's a 
non-critical fix since it's a corner case only and it will be in the next -ck 
anyway.

-- 
-ck
