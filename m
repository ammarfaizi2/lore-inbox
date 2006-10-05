Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWJEA1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWJEA1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWJEA1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:27:25 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:58583 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1751248AbWJEA1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:27:25 -0400
Date: Wed, 4 Oct 2006 17:26:37 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061005002637.GA5145@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org> <20061004195229.GA4459@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org> <20061004204718.GA4599@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041522190.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610041522190.3952@g5.osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 03:26:09PM -0700, Linus Torvalds wrote:
> 
> The very fact that this turned into a discussion is a sign that the ABI 
> breakage wasn't handled well enough. Usually, when we do something, nobody 
> ever even notices.

	There was the grand total of *ONE* user who was personally
impacted by the userspace API change (the two other, one was hit by a
bug, now fixed, one was hit because of kernel API change + external
driver). And I immediately proposed to postpone the change to a later
time.
	The people who contributed most to this tread were had not
experienced any breakage. I don't know what conclusion to reach from
that, and I don't understand why it took such proportions.

	Guessing the right time to deprecate an old API can be a trial
and error process. So, we just have to wait for the release of FC6...

	Jean
