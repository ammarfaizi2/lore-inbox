Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270700AbTGUTcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270702AbTGUTbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:31:51 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:2203 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S270700AbTGUTaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:30:23 -0400
Date: Mon, 21 Jul 2003 12:45:14 -0700
From: Larry McVoy <lm@bitmover.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-ID: <20030721194514.GA5803@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <20030721190226.GA14453@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721190226.GA14453@matchmail.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't need the tags, use dates.  You can get the date range you want 
with an rlog of the ChangeSet file and then use those dates.

On Mon, Jul 21, 2003 at 12:02:26PM -0700, Mike Fedyk wrote:
> ----- Forwarded message from Andrea Arcangeli <andrea@suse.de> -----
> 
> Delivery-date: Mon, 21 Jul 2003 11:52:43 -0700
> Date: Mon, 21 Jul 2003 12:20:33 -0400
> From: Andrea Arcangeli <andrea@suse.de>
> To: Stephan von Krawczynski <skraw@ithnet.com>
> Cc: marcelo@conectiva.com.br, mason@suse.com, riel@redhat.com,
> 	linux-kernel@vger.kernel.org, maillist@jg555.com
> Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
> User-Agent: Mutt/1.4i
> X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
> X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
> X-Mailing-List: linux-kernel@vger.kernel.org
> X-Spam-Status: No, hits=-3.1 required=5.0
> 	tests=EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,RCVD_IN_ORBS,
> 	      RCVD_IN_RFCI,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT,
> 	      X_MAILING_LIST
> 	version=2.55
> X-Spam-Level: 
> X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
> 
> On Mon, Jul 21, 2003 at 05:05:17PM +0200, Stephan von Krawczynski wrote:
> > On Mon, 21 Jul 2003 10:49:06 +0200
> > Stephan von Krawczynski <skraw@ithnet.com> wrote:
> > 
> > > On Fri, 18 Jul 2003 11:14:15 -0300 (BRT)
> > > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > > 
> > > > 
> > > > I have just started stress testing a 8way OSDL box to see if I can
> > > > reproduce the problem. I'm using pre6+axboes BH_Sync patch.
> > > > 
> > > > I'm running 50 dbench clients on aic7xxx (ext2) and 50 dbench clients on
> > > > DAC960 (ext3). Lets see what happens.
> > > > 
> > > > After lunch I'll keep looking at the oopses. During the morning I only had
> > > > time to setup the OSDL box and start the tests.
> > > 
> > > Hello Marcelo,
> > > 
> > > have you seen anything in your tests? My box just froze again after 3 days
> > > during NFS action. This was with pre6, I am switching over to pre7.
> > 
> > I managed to freeze the pre7 box within these few hours. There was no nfs
> > involved, only tar-to-tape.
> > I switched back to 2.4.21 to see if it is still stable.
> > Is there a possibility that the i/o-scheduler has another flaw somewhere (just
> > like during mount previously) ...
> 
> is it a scsi tape? Is the tape always involved? there are st.c updates
> between 2.4.21 to 22pre7. you can try to back them out.
> 
> If only the BKCVS would provide the tags in all files and not only in
> the file ChangeSets it would be very easy again to extract all the st.c
> updates. What happened to the BKCVS, why aren't the tags present in all
> the files anymore? Is it a mistake or intentional?
> 
> You should also provide a SYSRQ+P/T of the hang or we can't debug it at
> all.
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> ----- End forwarded message -----

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
