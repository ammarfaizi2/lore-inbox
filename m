Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbTFARYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264678AbTFARYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:24:22 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:9694 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264677AbTFARYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:24:21 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030531214520.5b7facf4.akpm@digeo.com>
References: <1054441433.1722.33.camel@iso-8590-lx.zeusinc.com>
	 <20030531214520.5b7facf4.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054488992.1722.42.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 13:36:32 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.5, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_03_05)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 00:45, Andrew Morton wrote:
> Tom Sightler <ttsig@tuxyturvy.com> wrote:
> >
> > I simply reniced this process to -10 and
> >  everything started working fine.  Upon looking a little further it
> >  seemed that the kernel was dynamically boosting the priority of the
> >  process much higher than it probably should be, in the end, not leaving
> >  enough CPU for playing the sounds without skipping.
> 
> Yes, it seems that too many real-world applications are accidentally
> triggering this problem.
> 
> Could you please run an strace of the boosted process, find out what it is
> doing to get itself boosted in this manner?  Wait until things are in
> steady state and the process is boosted, then run `strace -tt <pid>' so we
> see the timing info.

The strace was quite large so I have uploaded it to
http://tuxyturvy.com/strace-pluginserver.gz

Please let me know if you need more info or if I can help in other ways.

Thanks,
Tom




