Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbUKQAg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUKQAg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUKQAeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:34:36 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:38019 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262134AbUKQAcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:32:51 -0500
Date: Wed, 17 Nov 2004 01:32:48 +0100
From: David Weinehall <tao@acc.umu.se>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [BUG][2.6.10-rc2-bk1] ACPI S3 suspend to RAM broken (may be USB unable to resume)
Message-ID: <20041117003248.GA5226@khan.acc.umu.se>
Mail-Followup-To: Shawn Starr <shawn.starr@rogers.com>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	acpi-devel@lists.sourceforge.net
References: <200411161838.28344.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411161838.28344.shawn.starr@rogers.com>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 06:38:27PM -0500, Shawn Starr wrote:
> 
> As of 2.6.10-rc1 + I can no longer resume from S3 (suspend-to-RAM),  When it 
> begins to resume, it seems to get stuck with USB (going to confirm).. The 
> laptop stays in a stuck state (cresent-moon remains lit).

I experience the same problem, but if I remove the snd_intel8x0 driver
before suspending, resume works properly.  This problem started with
-rc1-bk15 for me; which is interesting since there doesn't seem to be
any changes to snd_intel8x0 between -bk13 and -bk15...

> I have IBM-ACPI extras turned on (compiled in).
> 
> Anyone else report this?


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
