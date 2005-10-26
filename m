Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbVJZOoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbVJZOoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 10:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJZOoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 10:44:02 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:41613
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751497AbVJZOoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 10:44:01 -0400
Message-Id: <435FB26B.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 26 Oct 2005 16:44:27 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Cc: <discuss@x86-64.org>
Subject: DIE_GPF vs. DIE_PAGE_FAULT/DIE_TRAP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the reason for notify_die(DIE_GPF, ...) to be run late in the GP
fault handler (on both i386 and x86-64), while for other exceptions it
gets run first thing (as I would have expected for all exceptions)?

Thanks, Jan
