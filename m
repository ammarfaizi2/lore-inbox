Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVBPWCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVBPWCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBPWCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:02:40 -0500
Received: from mail.charite.de ([160.45.207.131]:64652 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262100AbVBPWAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:00:08 -0500
Date: Wed, 16 Feb 2005 23:00:07 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
Message-ID: <20050216220007.GQ19871@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050215145618.GP24211@charite.de> <20050216153338.GA26953@atrey.karlin.mff.cuni.cz> <20050216200441.GH19871@charite.de> <1108590885.17089.17.camel@dale.velocity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1108590885.17089.17.camel@dale.velocity.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dale Blount <linux-kernel@dale.us>:

> This looks very similar (at least to me) to an OOPS I posted with 2.6.9
> on 12/03/2004.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110210705504716&w=2

Could be.

> My system is also a dual Xeon using SMP and Hyperthreading
> (/proc/cpuinfo shows 4 cpus).

Same system here.

> Mine, like Ralf's, is also a mail server running postfix using ext3 for
> the spool directory.

Same here.

> I've actually hit this bug (assuming it's the same) with 2.6.10 also.  I
> had to power cycle remotely and unfortunately didn't have the serial
> console logging enabled when it happened with 2.6.10.  I upgraded from
> 2.4.23 to 2.6.8.1 and crashed within a week, and continued to crash at
> least monthly after that.  It had been running 2.4.23 for 200+ days with
> no problems.
> 
> Hope this helps trace it back.

Me too


-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
