Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267606AbUG3FML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267606AbUG3FML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267610AbUG3FMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:12:10 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:26797 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S267606AbUG3FMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:12:01 -0400
Date: Fri, 30 Jul 2004 07:11:49 +0200
From: David Weinehall <tao@acc.umu.se>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: Shawn Starr <shawn.starr@rogers.com>, "'Brown, Len'" <len.brown@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI][2.6.8-rc2-bk #] - ACPI shutdown problems on IBM Thinkpads (T42)
Message-ID: <20040730051149.GM22472@khan.acc.umu.se>
Mail-Followup-To: Vernon Mauery <vernux@us.ibm.com>,
	Shawn Starr <shawn.starr@rogers.com>,
	"'Brown, Len'" <len.brown@intel.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <29AC424F54821A4FB5D7CBE081922E400131B410@hdsmsx403.hd.intel.com> <000301c47518$d6784e50$0200080a@panic> <20040729064338.GF22472@khan.acc.umu.se> <1091120589.14718.4.camel@bluerat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091120589.14718.4.camel@bluerat>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 10:03:10AM -0700, Vernon Mauery wrote:
> The latest (acpi-20040715) ACPI patch against 2.6.7/2.6.8-rc2 works on
> my T40 to bring back ACPI  interrupts after suspend/resume.  I don't
> know if these will apply to the bk tree or not.  It also makes it so
> other buttons besides the power button can wake up the machine (like the
> Fn button).

Thanks!  This indeed works.  However, Fn+F4 to suspend doesn't work now
(despite generating the proper interrupt), but that might be a
misconfiguration on my behalf.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
