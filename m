Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVF3NsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVF3NsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVF3NsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:48:23 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:34524 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262813AbVF3NsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:48:09 -0400
Date: Thu, 30 Jun 2005 23:48:06 +1000
From: David McCullough <davidm@snapgear.com>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: ocf-linux-200506300 - Asynchronous Crypto support for linux
Message-ID: <20050630134806.GA30067@beast>
References: <20050520135723.GB26883@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520135723.GB26883@beast>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

A new release of the ocf-linux package is up:

	http://ocf-linux.sourceforge.net/

A lot of changes in this release.  Best to check the Changelog below
for the specifics.  Most of the changes have centered around RNG, PKE
or getting Openswan running with OCF.

No 2.6 testing was done for this release,  but it should be close
if it doesn't work.

Changes:
* Full openswan v2.3.0 acceleration (including userland crypto/PKE support)
* Performance improvements
* Lots of fixes for IXP driver
   - builds for 1.4 and 2.0 access libs
   - task queues to handle possible blocking calls
   - problems calling perform from registration callback
   - many more ...
* MD5/SHA hash fixes for safenet on big endian machines
* New kernel speed test module to compare kernel crypto speeds

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
