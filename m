Return-Path: <linux-kernel-owner+w=401wt.eu-S932839AbWLNQBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbWLNQBg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbWLNQBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:01:35 -0500
Received: from hera.kernel.org ([140.211.167.34]:42778 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932839AbWLNQBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:01:35 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 11:01:34 EST
Date: Thu, 14 Dec 2006 15:37:53 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.34-rc2
Message-ID: <20061214153753.GA31342@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the second and hopefully last release candidate for 2.4.34.
It fixes vulnerability CVE-2006-6106 affecting bluetooth (with
With malformed packets it might be possible to overwrite internal
CMTP and CAPI data structures).

Please build and test this version, especially on non-x86 archs.
I intend to release 2.4.34 within a few days if nobody complains.

Regards,
Willy


Summary of changes from v2.4.34-rc1 to v2.4.34-rc2
============================================

Marcel Holtmann (1):
      [Bluetooth] Add packet size checks for CAPI messages (CVE-2006-6106)

Willy Tarreau (1):
      Change VERSION to 2.4.34-rc2

