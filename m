Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbTL1BJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 20:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTL1BJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 20:09:16 -0500
Received: from rth.ninka.net ([216.101.162.244]:25984 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264913AbTL1BJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 20:09:14 -0500
Date: Sat, 27 Dec 2003 17:09:03 -0800
From: "David S. Miller" <davem@redhat.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, anton@mips.complang.tuwien.ac.at,
       linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-Id: <20031227170903.73bc0198.davem@redhat.com>
In-Reply-To: <m1smj596t1.fsf@ebiederm.dsl.xmission.com>
References: <179fV-1iK-23@gated-at.bofh.it>
	<179IS-1VD-13@gated-at.bofh.it>
	<2003Dec27.212103@a0.complang.tuwien.ac.at>
	<Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
	<m1smj596t1.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Dec 2003 16:31:22 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 2) Creating zones for the different colors.  Zones were not
>    implemented last time, this was tried.

While this idea might sound promising, it would not work
because by definition all pages of a particular color cannot
be coalesced into order 1 or larger buddies.
