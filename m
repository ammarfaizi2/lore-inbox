Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422890AbWBCTwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbWBCTwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422907AbWBCTwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:52:25 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:4065 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1422890AbWBCTwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:52:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID5 unusably unstable through 2.6.14
Date: Fri, 3 Feb 2006 14:52:23 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C99DE@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID5 unusably unstable through 2.6.14
Thread-Index: AcYo+rN+/a4I3ugoStGUiQGFI3GdnQAACS3A
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Martin Drab" <drab@kepler.fjfi.cvut.cz>,
       "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi [mailto:psusi@cfl.rr.com] sez:
> Salyzyn, Mark wrote:
> > The drive is low level formatted. This resolved the problem you were
> > having.
> Could you define what you mean by "low level format"?

SCSI, SATA and SAS drives all offer a FORMAT command. The Drive
manufacturers will perform whatever operations they deem fit to this
command (if available).

The Low Level Format option in the BIOS configuration tool will issue
this command. There is also options for a Zero or Secure Format, which
writes patterns to the drives.

-- Mark Salyzyn
