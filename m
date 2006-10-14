Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWJNDEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWJNDEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 23:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWJNDEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 23:04:50 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:10772 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030229AbWJNDEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 23:04:49 -0400
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>,
       Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>,
       Greg KH <greg@kroah.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 13 Oct 2006 20:04:46 -0700
In-Reply-To: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org> (Alan Stern's message of "Fri, 13 Oct 2006 22:33:04 -0400 (EDT)")
Message-ID: <adak6334my9.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Oct 2006 03:04:47.0330 (UTC) FILETIME=[819E0C20:01C6EF3D]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Alan> That seems like a reasonable thing to do.  (BTW, can anyone
    Alan> explain quickly what "BIST" means?)

"Built-In Self Test" -- make the device go away and run some internal
tests for a while and then report back.
