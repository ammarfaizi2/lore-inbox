Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUG2Gnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUG2Gnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 02:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUG2Gnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 02:43:45 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:25322 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S264373AbUG2Gnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 02:43:42 -0400
Date: Thu, 29 Jul 2004 08:43:38 +0200
From: David Weinehall <tao@debian.org>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: "'Brown, Len'" <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI][2.6.8-rc2-bk #] - ACPI shutdown problems on IBM Thinkpads (T42)
Message-ID: <20040729064338.GF22472@khan.acc.umu.se>
Mail-Followup-To: Shawn Starr <shawn.starr@rogers.com>,
	"'Brown, Len'" <len.brown@intel.com>, linux-kernel@vger.kernel.org
References: <29AC424F54821A4FB5D7CBE081922E400131B410@hdsmsx403.hd.intel.com> <000301c47518$d6784e50$0200080a@panic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c47518$d6784e50$0200080a@panic>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 11:05:00PM -0400, Shawn Starr wrote:
> 
> I'll keep looking for patches as you get time.
> 
> I appreciate your help.

Disable APIC support and shutdown will work.

Meanwhile, has anyone solved the problem with the Thinkpad-keys after
a suspend/resume?  Volume keys still work, as does the brightness keys,
but Fn+F4 for suspend doesn't (manual suspend still works), and tpb
doesn't see any of the Thinkpad specific keypresses any longer
("Access IBM", Fn+Fx, etc), not even if I restart tpb, and
/proc/interrupts:acpi indicates that interrups are not working for ACPI
any longer.  All other interrupts seem to function properly, and I have
both patches from [1] applied.

[1] http://bugme.osdl.org/show_bug.cgi?id=2643


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
