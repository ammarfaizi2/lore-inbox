Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbULGGKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbULGGKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 01:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbULGGK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 01:10:29 -0500
Received: from smtp2.eldosales.com ([63.78.12.18]:7443 "EHLO
	tweeter.eldosales.com") by vger.kernel.org with ESMTP
	id S261765AbULGGKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 01:10:24 -0500
Posted-Date: Mon, 6 Dec 2004 23:10:23 -0700
Subject: qla2xxx fail over bug?
From: comsatcat <comsatcat@earthlink.net>
Reply-To: comsatcat@earthlink.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 06 Dec 2004 23:09:59 -0700
Message-Id: <1102399799.12866.3.camel@solaris.skunkware.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm doing fail over testing with a Qlogic 2344 (only using ports 1 and
2).  I've successfully failed over from 1 port to 2, then failed back to
port 1, however, when I pull both cables, then plug in port 2 or 1, fail
over will not take affect.  I am required to plug in both cables in
order to get the devices back online.

I got the following messages from the qla2xxx driver when I plugged a
single cable back in after pulling both:

Dec  6 23:05:26 fe-nntp-07 kernel: qla2x00: no more failovers for
request - pid= 2210820

This message would scroll continuously.

Any comments or ideas?  Is this a bug or a feature?

Thanks,
Ben

