Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271736AbTGRM0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271735AbTGRM0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:26:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:53737 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S271722AbTGRM0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:26:38 -0400
Date: Fri, 18 Jul 2003 14:41:27 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Message-ID: <20030718124127.GF6520@marowsky-bree.de>
References: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org> <20030718122304.A23013@infradead.org> <20030718121202.GC6520@marowsky-bree.de> <20030718131352.A26546@infradead.org> <20030718122622.GD6520@marowsky-bree.de> <20030718133404.A26784@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030718133404.A26784@infradead.org>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-07-18T13:34:04,
   Christoph Hellwig <hch@infradead.org> said:

> So what?  Vendor ship all kinds of strange stuff and we can't really
> keep the compat cruft for that around.  And the mpio stuff in qla2xxx
> is _lots_ of cruft.

The other points you mentioned preclude merging it into mainline right
now anyway and needs fixing. Your comments there are spot on.

However, while I agree about this being cruft in qla2xxx, it is _used_.
It's a driver / HBA feature which is actively deployed. I'd like to see
it go sooner than later, but by blocking this feature you preclude
those users of the driver from using the mainline one again, which is
the entire point of this exercise.

Dropping such a feature needs some preparation to protect the users, and
isn't justified by the personal dislikes of myself or you I'm afraid
;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
