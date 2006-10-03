Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWJCSUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWJCSUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWJCSUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:20:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:11241 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964889AbWJCSUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:20:11 -0400
Message-ID: <4522A9BE.9000805@garzik.org>
Date: Tue, 03 Oct 2006 14:19:42 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net, jt@hpl.hp.com
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com>
In-Reply-To: <20061003180543.GD23912@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> The more we can clean-up the WE API, the easier it will be to implement
> the cfg80211 WE compatibility layer intended for wireless-dev.
> I think WE-21 makes things better in that respect.
> 
> Finally, I already scaled-back Jean's original WE-21 patch.  I only
> anticipate minor bug fixes for WE from now on, with nl80211/cfg80211
> as the heir-apparent.
> 
> With all that said, I'd prefer to keep the existing WE-21 patches and
> add Jean's fixes ASAP.  Is this acceptable?  If not, I'll submit the
> reversions to Jeff ASAP.

I for one don't want to change the userspace ABI for this...  If I had 
realized the userspace ABI was changing (<- my fault), I wouldn't have 
merged the changes in the first place.

	Jeff


