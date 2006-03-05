Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWCEUc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWCEUc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 15:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWCEUc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 15:32:28 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30885 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750733AbWCEUc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 15:32:27 -0500
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe
	motherboards
From: Lee Revell <rlrevell@joe-job.com>
To: bjd <bjdouma@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
In-Reply-To: <20060305192709.GA3789@skyscraper.unix9.prv>
References: <20060305192709.GA3789@skyscraper.unix9.prv>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 15:32:22 -0500
Message-Id: <1141590742.14714.102.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 20:27 +0100, bjd wrote:
> From: Bauke Jan Douma <bjdouma@xs4all.nl>
> 
> On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
> and MC97 modem controller are deactivated when a second PCI soundcard
> is present.  This patch enables them.

Thanks for fixing this!  We get a ton of complaints about this "feature"
on the ALSA lists.

Do we have any idea why ASUS would have done such a thing?  Users hate
it.  Are they working around a hardware or Windows bug?

Lee

