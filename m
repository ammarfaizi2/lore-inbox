Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUHJJzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUHJJzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUHJJzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:55:45 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:18579 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263815AbUHJJwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:52:24 -0400
Date: Tue, 10 Aug 2004 11:52:23 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810095223.GJ10361@merlin.emma.line.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1092082920.5761.266.camel@cube> <1092124796.1438.3695.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092124796.1438.3695.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That seems reasonable, but _only_ if burnfree is not enabled. If the
> hardware _supports_ burnfree but it's disabled, the warning should also
> recommend turning it on.

burnfree causes a few broken pits/lands on the CD-R so it is best
avoided if the hardware can do it. That you don't see these is a matter
of the reading drive not exporting such information and EFM and CIRC
usually correcting them, but it's still lower quality than a burn
process that hadn't needed burnfree at all.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
