Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbRL2RXR>; Sat, 29 Dec 2001 12:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284956AbRL2RXH>; Sat, 29 Dec 2001 12:23:07 -0500
Received: from [24.243.44.28] ([24.243.44.28]:62225 "EHLO explorer.dummynet")
	by vger.kernel.org with ESMTP id <S285073AbRL2RWt>;
	Sat, 29 Dec 2001 12:22:49 -0500
Date: Sat, 29 Dec 2001 11:22:23 -0600
From: Dan Hopper <dbhopper@austin.rr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help editorial policy
Message-ID: <20011229112223.A19085@explorer.dummynet>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011227152249.B15022@suse.cz> <E16JdcQ-00061o-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <E16JdcQ-00061o-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> remarked:
> Beg to differ. E1 is only 2048000 bits/second if you never send 5
> consecutive 1 bits. The actual data rate on an E1 is in fact variable

To the best of my recollection, the line bit (symbol) rate is fixed
at, ideally, 2048000 bps.  At least with HDB3 line coding, a
sequence of 4 consecutive zeroes is replaced with three midscale
values one the line, and a mark that violates the normal mark
alternation scheme.  I.e. 1,0,0,0,0 might be replaced with +,0,0,0,+

Thus, the "payload" data rate of 2048000 equals the line symbol
rate of 2048000 symbols/sec.  (Of course, this isn't really the
"payload" data, since it includes the framing slots and all that,
but...)

Dan
