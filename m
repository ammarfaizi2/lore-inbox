Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbTJJQwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTJJQuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:50:50 -0400
Received: from [66.212.224.118] ([66.212.224.118]:61201 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263061AbTJJQua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:50:30 -0400
Date: Fri, 10 Oct 2003 12:50:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.0-test7 - 2003-10-09.18.30) - 1 New warnings (gcc
 3.2.2)
In-Reply-To: <200310100645.h9A6joFZ008847@cherrypit.pdx.osdl.net>
Message-ID: <Pine.LNX.4.53.0310101249380.15705@montezuma.fsmlabs.com>
References: <200310100645.h9A6joFZ008847@cherrypit.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, John Cherry wrote:

> drivers/media/common/saa7146_vbi.c:6: warning: `vbi_workaround' defined but not used

That appears bogus, it's used in vbi_open on line 374
