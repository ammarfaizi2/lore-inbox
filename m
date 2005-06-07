Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVFGMIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVFGMIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 08:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFGMIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 08:08:44 -0400
Received: from sorrow.cyrius.com ([65.19.161.204]:18191 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S261842AbVFGMHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 08:07:51 -0400
Date: Tue, 7 Jun 2005 13:07:27 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: stefandoesinger@gmx.at, acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM))
Message-ID: <20050607120727.GA6077@deprecation.cyrius.com>
References: <200506061531.41132.stefandoesinger@gmx.at> <1118125410.3828.12.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118125410.3828.12.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Shaohua Li <shaohua.li@intel.com> [2005-06-07 14:23]:
> For those who suffer from strange S3 resume problem such as resume hang,
> could you please try this debug patch.

This works on a HP Compaq nc4000 which previously never comes back
from resume (except for one time in which case the kernel oopsed in a
strange way, as posted by Matthew the other day).  I see a yellow
'Linu' on the screen, then I hear the hard drive spinning up, the
screen comes back and I see 'Restarting tasks... done' on the serial
console.  (this is with init=/bin/bash console=ttyS0)
-- 
Martin Michlmayr
http://www.cyrius.com/
