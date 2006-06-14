Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWFNAEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWFNAEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWFNAER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:04:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:3748 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964823AbWFNACe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:02:34 -0400
From: Neil Brown <neilb@suse.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Date: Wed, 14 Jun 2006 10:02:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17551.21000.94210.883031@cse.unsw.edu.au>
Cc: Bernd Petrovitsch <bernd@firmix.at>, David Schwartz <davids@webmaster.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>, jdow <jdow@earthlink.net>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
In-Reply-To: message from Kyle Moffett on Monday June 12
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	<193701c68d16$54cac690$0225a8c0@Wednesday>
	<1150100286.26402.13.camel@tara.firmix.at>
	<AC44C19E-109F-4DD4-933E-B641BF3BF9CB@mac.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 12, mrmacman_g4@mac.com wrote:
> On Jun 12, 2006, at 04:18:06, Bernd Petrovitsch wrote:
> > No. SPF simply defines legitimate outgoing MTAs for a given domain.
> 
> I'm sorry, but the internet just doesn't work that way.  I have 3  
> email accounts (mac.com, vt.edu, and cox.net).  Both my college and  
> my house deny all SMTP to anyone but their local servers.  If mac.com  
> published an SPF filter and VGER used the SPF filter, I would have no  
> way at all to send mail via this account, simply for the reason that  
> neither of my local ISPs will allow my to directly send email to  
> mac.com.  Likewise for my vt.edu account while at home or my cox.net  
> account while at college.

But I'm sure if that happened you could find a way.
The 'best' way would be for mac.com (and everyone else) to accept mail
submission (and only authenticated mail submission) on the
'submission' port (which is an IETF standard RFC2476).
Then port-25 blocking wouldn't be a problem for you.

Now, it could be that SPF might become a standards-track RFC.  And if
it did (may not be likely, but should be seen as possible as a lot of
people are pushing despite the fact that many push back) then people
would feel justified in implementing it and you might start to find
your mail isn't getting through.

So if you want to be sure of continued access to your mac.com mail
address, I would suggest you try lobbying the mac.com admins to
support 'submission' (I notice it doesn't currently).  Then you can
start using 'submission' to submit mail.  And you can use exactly the
same mail configuration no matter what ISP you are talking through,
and you will be ready in case the crazy loons out there do manage to
convince IETF to move SPF to the standards-track.

		  Don't be held hostage by your ISP.
	   Insist on using 'submission' for mail submission.

NeilBrown
