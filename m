Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSKKVc2>; Mon, 11 Nov 2002 16:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSKKVc2>; Mon, 11 Nov 2002 16:32:28 -0500
Received: from holomorphy.com ([66.224.33.161]:47799 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261399AbSKKVc1>;
	Mon, 11 Nov 2002 16:32:27 -0500
Date: Mon, 11 Nov 2002 13:36:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: john stultz <johnstul@us.ibm.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021111213626.GO23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
	john stultz <johnstul@us.ibm.com>, Vojtech Pavlik <vojtech@suse.cz>,
	Linus Torvalds <torvalds@transmeta.com>,
	Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <johnstul@us.ibm.com> <1037047250.1625.5.camel@cornchips> <200211112057.gABKvS620539@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211112057.gABKvS620539@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 03:57:28PM -0500, J.E.J. Bottomley wrote:
> As a beginning, what about the attached patch?  It eliminates the
> compile time TSC options (and thus hopefully the sources of confusion).
> I've exported tsc_disable, so it can be set by the subarchs if desired
> (voyager does this) and moved the notsc option into the timer_tsc code
> (which is where it looks like it belongs).

This will be very useful to me.


Thanks,
Bill
