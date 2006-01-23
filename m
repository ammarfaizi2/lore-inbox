Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWAWUWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWAWUWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWAWUWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:22:39 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:40629 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932466AbWAWUWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:22:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17365.15058.133950.726063@wombat.chubb.wattle.id.au>
Date: Tue, 24 Jan 2006 07:21:38 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Chase Venters <chase.venters@clientec.com>,
       Michael Loftis <mloftis@wgops.com>,
       "Barry K. Nathan" <barryn@pobox.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
In-Reply-To: <20060123131707.GA20163@mail.shareable.org>
References: <200601212108.41269.a1426z@gawab.com>
	<986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	<E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	<200601222346.24781.chase.venters@clientec.com>
	<20060123131707.GA20163@mail.shareable.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jamie" == Jamie Lokier <jamie@shareable.org> writes:

Jamie> Chase Venters wrote:
>> Just as a curiosity... does anyone have any guesses as to the
>> runtime performance cost of hosting one or more swap files (which
>> thanks to on demand creation and growth are presumably built of
>> blocks scattered around the disk) versus having one or more simple
>> contiguous swap partitions?

>> I think it's probably a given that swap partitions are better; I'm
>> just curious how much better they might actually be.

Jamie> When programs must access files in addition to swapping, and
Jamie> that includes demand-paged executable files, swap files have
Jamie> the _potential_ to be faster because they provide opportunities
Jamie> to use the disk nearer the files which are being accessed.

If you can, put your swap on a different spindle...


Actually, the original poster's `dream' looked a lot like a
single-address-space operating system, such as Mungi (
http://www.cse.unsw.edu.au/~disy/Mungi/ )
-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
