Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbTL3Uah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265918AbTL3Uag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:30:36 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:10631 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S265905AbTL3Uaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:30:35 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16369.57428.470813.237725@jik.kamens.brookline.ma.us>
Date: Tue, 30 Dec 2003 15:30:12 -0500
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
In-Reply-To: <20031230202540.GE6992@bounceswoosh.org>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
	<20031229195235.GC26821@bounceswoosh.org>
	<16369.25514.425834.153361@jik.kamens.brookline.ma.us>
	<20031230200643.GC6992@bounceswoosh.org>
	<16369.56307.995425.595117@jik.kamens.brookline.ma.us>
	<20031230202540.GE6992@bounceswoosh.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama writes:
 > UDMA modes include a checksum on every transfer, for both reads and
 > writes.

This contradicts what I was told previously by another subscriber to
this list.

If it is true, then it would appear that the answer to my question "Is
it save to ignore UDMA BadCRC errors?" is "Yes."  If all transfers are
checksummed, and if all transfers with bad checksums will be retried
by the kernel, then occasional checksum errors are harmless because
they will be retried.  Do you agree?

Thanks,

  jik
