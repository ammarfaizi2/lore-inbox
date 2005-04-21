Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVDURdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVDURdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDURdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:33:41 -0400
Received: from palrel13.hp.com ([156.153.255.238]:42964 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261567AbVDURdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:33:37 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16999.58345.464613.343890@napali.hpl.hp.com>
Date: Thu, 21 Apr 2005 10:33:29 -0700
To: "Luck, Tony" <tony.luck@intel.com>
Cc: <davidm@hpl.hp.com>, <akpm@osdl.org>,
       "Andreas Hirstius" <Andreas.Hirstius@cern.ch>,
       "Bartlomiej ZOLNIERKIEWICZ" <Bartlomiej.Zolnierkiewicz@cern.ch>,
       "Gelato technical" <gelato-technical@gelato.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [Gelato-technical] Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7 and later
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0350B393@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0350B393@scsmsx401.amr.corp.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 21 Apr 2005 10:19:28 -0700, "Luck, Tony" <tony.luck@intel.com> said:

  >> I just checked 2.6.12-rc3 and the fls() fix is indeed missing.
  >> Do you know what happened?

  Tony> If BitKeeper were still in use, I'd have dropped that patch
  Tony> into my "release" tree and asked Linus to "pull" ... but it's
  Tony> not, and I was stalled.  I should have a "git" tree up and
  Tony> running in the next couple of days.  I'll make sure that the
  Tony> fls fix goes in early.

Yeah, I'm facing the same issue.  I started playing with git last
night.  Apart from disk-space usage, it's very nice, though I really
hope someone puts together a web-interface on top of git soon so we
can seek what changed when and by whom.

	--david
