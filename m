Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUIGHGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUIGHGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 03:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUIGHGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 03:06:38 -0400
Received: from web11906.mail.yahoo.com ([216.136.172.190]:15882 "HELO
	web11906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267483AbUIGHGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 03:06:35 -0400
Message-ID: <20040907070635.7268.qmail@web11906.mail.yahoo.com>
Date: Tue, 7 Sep 2004 00:06:35 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: [BUG] r200 dri driver deadlocks
To: Dave Airlie <airlied@gmail.com>
Cc: Felix =?ISO-8859-1?Q?=20=22K=FChling=22?= <fxkuehl@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>, diablod3@gmail.com,
       dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
In-Reply-To: <21d7e99704090623544c6ecaf5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most IMPORTANT is that some-one some-where there is a list of ALL of
these.  These are best in the form of code comments so the the respective
places in the code can be changed.

--- Dave Airlie <airlied@gmail.com> wrote:

> > Dose the DRM varify that the cmds are in this order?  Why not just
> have
> > the DRM 'sort' the cmds?  A simple bouble sort would have no more
> overhead
> > then the check for correct order, but it would fix missordered cmd
> > streams.
> > 
> > Once this is done the statement holds true, userland stuff should
> never...
> > 
> 
> Feel free to implement it and profile it, but there are so many ways
> to lock up a radeon chip it is scary, the above was just one example,
> some days if you look at it funny it can lockup :-), it is accepted
> that userland can crap out 3D chips, the Intel ones are fairly easy to
> hangup also..
> 
I'd love to, where do I start?  The problem he is that I have no-idea...
1. What values I'd neet to test for and sort.
2. The order of the sorting(probly documented in DRI-client code).
3. Where in the DRM I can proform the needed test and sort.

I would also love a list of ALL of these so I can fix them one by one.  A
good project for a new DRI developer, no.

> Dave.
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
