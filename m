Return-Path: <linux-kernel-owner+w=401wt.eu-S933185AbWLaOW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbWLaOW2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 09:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933184AbWLaOW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 09:22:27 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:40470 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933182AbWLaOW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 09:22:27 -0500
Message-ID: <4597C7AB.60403@lwfinger.net>
Date: Sun, 31 Dec 2006 08:22:35 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [OOPS] bcm43xx oops on 2.6.20-rc1 on x86_64
References: <Pine.LNX.4.64.0612171510030.17532@squeaker.ratbox.org> <20061230192104.GB20714@stusta.de> <4596D8DE.2030408@lwfinger.net> <20061230213245.GD20714@stusta.de> <4596EC01.3060508@lwfinger.net> <20061231134302.GJ20714@stusta.de>
In-Reply-To: <20061231134302.GJ20714@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> To avoid any misunderstandings:
> 
> This wasn't in any way meant against you personally.
> 
> And in this case you were right, it was the same bug.
> 
> My answer was based on experiences like one during 2.6.19-rc where we 
> had 4 bug reports for a regression with a patch available. And it turned 
> out that one of them was for a completely different regression.
> 
> That's why I prefer to get confirmations that a user actually run into 
> the same issue, and not into something completely different with similar 
> symptoms.

I certainly understood your intent and agree that confirmation is necessary. I was venting some
frustration at it taking nearly 3 weeks to get a fix into the system for a bug that was caused by a
change in an kernel structure that was not our doing. When Andrew posted a trial patch to fix the
compilation error that resulted, I immediately responded with the two additional fixes that were
needed, but they never made it into the code. Since then I have been seeing these obscure bug
reports and quickly learned that if either softmac or bcm43xx WX were involved, this fix took care
of the problem.

Larry

