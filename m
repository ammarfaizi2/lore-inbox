Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWGYMwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWGYMwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 08:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWGYMwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 08:52:05 -0400
Received: from mx01.qsc.de ([213.148.129.14]:19924 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S1751245AbWGYMwE convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 08:52:04 -0400
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCODE
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Date: Tue, 25 Jul 2006 14:51:37 +0200
User-Agent: KMail/1.9.3
Cc: Nikita Danilov <nikita@clusterfs.com>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
References: <44C12F0A.1010008@namesys.com> <17604.31639.213450.987415@gargle.gargle.HOWL> <20060725123558.GA32243@opteron.random>
In-Reply-To: <20060725123558.GA32243@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607251451.37821.rene@exactcode.de>
X-Spam-Score: -101.4 (---------------------------------------------------)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Tuesday 25 July 2006 14:35, Andrea Arcangeli
	wrote: ... > average of 5 minutes) they may not get logged in KLive.
	OTOH this also > means that all computers showing reiser4 in the logs
	had it mounted > since about the boot time (so if reiser4 would corrupt
	memory badly by > just mounting nobody could reasonably hope to reach 20
	days of > uptime). [...] 
	Content analysis details:   (-101.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-100 USER_IN_WHITELIST      From: address is in the user's white-list
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 25 July 2006 14:35, Andrea Arcangeli wrote:
...
> average of 5 minutes) they may not get logged in KLive. OTOH this also
> means that all computers showing reiser4 in the logs had it mounted
> since about the boot time (so if reiser4 would corrupt memory badly by
> just mounting nobody could reasonably hope to reach 20 days of
> uptime).

Well I tested Reiser4 on systems building our Linux flavour (based on the T2 
framework) thus with excessive software compilation, a lot of tarball 
extraction, compilation of fat packages such as linux, mozilla, openoffice 
et.al. and huge per-package ccache directories -> zilions of small files and 
did not encounter any abnormal behaviour aside the yet-to-be-fixed commit 
storms. Performance was superiour over ext3, XFS*, JFS or Reiser3 in this 
workload (that is less time "wasted" for FS housekeeping and the build 
finished noticable earlier). Patchset was tested around 2.6.1{4,5]. But I do 
not have the numbers around anymore and was basically waiting for Reiser4 to 
make it into the kernel to schedule further testing.

You can see I'm not a blind Reiser4 follower but would rather like to see a 
fair chance for it.

*) XFS oopsed so often in this test that I'll never touch it again ...

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45
