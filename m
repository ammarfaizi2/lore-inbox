Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030855AbWKOSo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030855AbWKOSo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030853AbWKOSo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:44:58 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:10198
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030855AbWKOSo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:44:57 -0500
From: Michael Buesch <mb@bu3sch.de>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: ANNOUNCE: SFLC helps developers assess ar5k (enabling free Atheros HAL)
Date: Wed, 15 Nov 2006 19:42:14 +0100
User-Agent: KMail/1.9.5
References: <20061115031025.GH3451@tuxdriver.com>
In-Reply-To: <20061115031025.GH3451@tuxdriver.com>
Cc: madwifi-devel@lists.sourceforge.net, lwn@lwn.net, mcgrof@gmail.com,
       david.kimdon@devicescape.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151942.14596.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 04:10, John W. Linville wrote:
> It is my pleasure to announce that the SFLC [1] has assisted the ar5k
> developers in evaluating the development history of Reyk Floeter's
> OpenBSD reverse-engineered Atheros HAL, ar5k [2].  SFLC's assessment
> leads to the conclusion that free software developers should not be
> worried about using/extending ar5k or porting ar5k to other platforms.
> 
> In the past there were serious questions raised and even dire warnings
> made about ar5k's copyright status.  The purpose of this statement
> is to refute those claims and to publicly clarify ar5k's status
> to developers.
> 
> SFLC has made independent inquiries with the OpenBSD team regarding the
> development history of ar5k source.  The responses received provide
> a reasonable basis for SFLC to believe that the OpenBSD developers
> who worked on ar5k did not misappropriate code, and that the ar5k
> implementation is OpenBSD's original copyrighted work.
> 
> This announcement should serve to remove the cloud which has prevented
> progress towards an in-kernel driver for Atheros hardware.  This should
> be of particular interest to those involved with the DadWifi project [3].
> 
> I'd like to take this opportunity to thank the folks at the SFLC for
> their hard work, and I'd also like to personally thank Luis Rodriguez
> for the role he played in coordinating contact between the SFLC and
> the community at large.
> 
> Thanks!
> 
> John
> 
> [1] http://www.softwarefreedom.org/
> [2] http://team.vantronix.net/ar5k/
> [3] http://marc.theaimsgroup.com/?l=linux-netdev&m=116113064513921&w=2

So, who is finally going to _DO_ the work?
Some of you know that I started an atheros driver at
http://bu3sch.de/ath/atheros.git/
It's not really a driver, yet, as nobody got to continue on the specification,
so I was stuck.

Now that it seems to be ok to use these openbsd sources, should I port
them to my driver framework?
I looked over the ar5k code and, well, I don't like it. ;)
I don't really like having a HAL. I'd rather prefer a "real" driver
without that HAL obfuscation.

-- 
Greetings Michael.
