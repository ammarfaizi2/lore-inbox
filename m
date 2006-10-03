Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWJCEGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWJCEGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWJCEGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:06:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:52710 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932339AbWJCEGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:06:06 -0400
From: Neil Brown <neilb@suse.de>
To: dean gaudet <dean@arctic.org>
Date: Tue, 3 Oct 2006 14:05:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17697.57742.653845.715710@cse.unsw.edu.au>
Cc: Erik Andersen <andersen@codepoet.org>, Lee Revell <rlrevell@joe-job.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
In-Reply-To: message from dean gaudet on Monday October 2
References: <1159539793.7086.91.camel@mindpipe>
	<20061002100302.GS16047@mea-ext.zmailer.org>
	<1159802486.4067.140.camel@mindpipe>
	<45212F39.5000307@mbligh.org>
	<1159804137.4067.144.camel@mindpipe>
	<20061002173951.GA8534@codepoet.org>
	<Pine.LNX.4.64.0610022029010.32183@twinlark.arctic.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 2, dean@arctic.org wrote:
> 
> it sure would be nice if posting were subscribers-only.
> 

How about adding a header to messages posted by non-subscribers
 X-vger-kernel-org: non-subscriber

and maybe even a different footer:

--
 This mail was from a non-subscriber and may not have reached all
 subscribers. 

Then people who think the list should be subscriber-only could enforce
that locally, and people who want to be more broad-minded still have
that option.


Then something like:
 IF it is from a subscriber
  OR it has a subject mentioning my area of interest 
 THEN let it through
 ELSE apply strict spam checks.

I'd really like to add 
  OR in reply to some lkml message, but as as Message-id: is left
  untouch when the mail is forwarded (probably a good thing) that
  doesn't seem to be possible.

NeilBrown
