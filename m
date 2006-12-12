Return-Path: <linux-kernel-owner+w=401wt.eu-S1751542AbWLLScQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWLLScQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWLLScP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:32:15 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:62870 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542AbWLLScO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:32:14 -0500
Message-ID: <457EF59E.8050001@lwfinger.net>
Date: Tue, 12 Dec 2006 12:31:58 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Ray Lee <ray-lk@madrabbit.org>
CC: Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Bcm43xx-dev@lists.berlios.de
Subject: Re: ieee80211 sleeping in invalid context
References: <455B63EC.8070704@madrabbit.org> <455F58AC.3030801@lwfinger.net> <457E2AE2.1020108@madrabbit.org> <200612121014.30309.mb@bu3sch.de> <457EEC1E.9000806@madrabbit.org>
In-Reply-To: <457EEC1E.9000806@madrabbit.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:
> Michael Buesch wrote:
>> Congratulations to your decision ;)
> 
> Sometimes making decisions via Brownian motion has its advantages.
> 
>> Which kernel are you using?
> 
> Hmm, I'm using the mercurial repository, let me see if I can translate that to a git
> head... Looks like git tree c2bb88baa52429b6b76e3ba4272cb2b29713c5a8 . (Which is from
> less than 24 hours ago.)
> 
>> There is some locking breakage in latest kernels with softmac.
>> I attached the fixes for the known bugs.
> 
> Okay, I'll apply to my local copy, rebuild, and try again. I'll let you know what
> happens.

Please note that the 3rd hunk of the second patch that Michael sent is already in Linus's 
2.6.19-gitXX tree. You may get that part rejected by patch.

Larry
