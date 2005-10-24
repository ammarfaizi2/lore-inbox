Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVJXTsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVJXTsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVJXTsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:48:45 -0400
Received: from mxsf22.cluster1.charter.net ([209.225.28.222]:48289 "EHLO
	mxsf22.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751246AbVJXTso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:48:44 -0400
X-IronPort-AV: i="3.97,245,1125892800"; 
   d="scan'208"; a="1726837098:sNHT22928632"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17245.14997.891283.954480@smtp.charter.net>
Date: Mon, 24 Oct 2005 15:48:37 -0400
From: "John Stoffel" <john@stoffel.org>
To: Michael Brade <brade@informatik.uni-muenchen.de>
Cc: "John Stoffel" <john@stoffel.org>, linux-kernel@vger.kernel.org
Subject: Re: ieee1394: sbp2: sbp2util_node_write_no_wait failed
In-Reply-To: <200510241834.03948.brade@informatik.uni-muenchen.de>
References: <200510241451.27320.brade@informatik.uni-muenchen.de>
	<17244.59851.9303.25151@smtp.charter.net>
	<200510241834.03948.brade@informatik.uni-muenchen.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michael" == Michael Brade <brade@informatik.uni-muenchen.de> writes:

>> One thing I suggest right off the bat is to make sure that firmware on
>> your external enclosure is updated to the latest/greatest.  Alot of
>> vendors (esp those using the Prolific chipset) don't get it right
>> initially.

Michael> Good guess and damn, yes, I've got the Icy Box IB-351-UE
Michael> which has the prolific chipset, I guess it's the (cursed)
Michael> PL3507. [The IcyBox FAQ says: IB-350/351/360UE Prolific
Michael> (PL3507) - Agere (FW8028)]

I've got the same box, and I've given up on the firewire side of
things and I just use the USB port now.  But it's just my backup box,
so I don't really use it too much.  

Michael> However, I've read that they had problems in 2004 and that
Michael> all new devices (starting from October 2004) have the updated
Michael> firmware already.

Check anyway... I think I posted recently about my luck in getting the
USB side working with 2.6.12+ once I updated the firmware on the
chipset, which was a pain.  

Michael> I have also found some of your posts from 2004 on lkml about
Michael> the prolific chipset, actually anything I found is mostly
Michael> from 2004 :-/

Yeah, from what I've been reading, the Prolific chipset sucked even
for Windows users, at least until the latest firmware.  Goto these
pages:

	http://tech.prolific.com.tw/visitor/v_filebrw_result.asp
	http://forum.rpc1.org/viewtopic.php?t=25140&postdays=0&postorder=asc&&start=25&sid=6801466c15ef74f35a490bbdb423cf37

The second one is a forum which had some useful info.

Michael> So sorry for the dumb question, but do I check if I've got
Michael> the newest firmware without windows? I had a look at
Michael> www.icybox.de but found no firmware for ib-351, only for
Michael> ib-350 and that one is from Dec 2004.

You need to go by chipset, not by enclosure.  I poked on my system,
but there's nothing obvious about how to get the firmware level in the
output of 'lsusb'.  Sorry.

Michael> And even if I've got the newest firmware already, does the
Michael> prolific stuff work by now or should I chuck it out the
Michael> window?

It works with USB, I don't know about firewire since I've just chucked
that for now.  Which is why I got the dual input setup, USB/Firewire.
Haven't tried the firewire on a Windows box either since the upgrade,
might one of these days, but I'm in no rush.

John
