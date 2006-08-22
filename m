Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWHVIeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWHVIeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWHVIeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:34:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35016 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932131AbWHVIeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:34:23 -0400
Date: Tue, 22 Aug 2006 10:34:15 +0200
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-Id: <20060822103415.848a88de.ak@suse.de>
In-Reply-To: <44EADD1A.76E4.0078.0@novell.com>
References: <20060820013121.GA18401@fieldses.org>
	<20060821212043.332fdd0f.akpm@osdl.org>
	<44EAD613.76E4.0078.0@novell.com>
	<200608221022.59255.ak@suse.de>
	<44EADD1A.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was thinking of the fixes to the fallback logic 

Ok that should be harmless (although I have my doubts it will fix Bruce's
particular problem)

> and the bottom-of-stack annotations.

You mean the push $0s to terminate the stack or something else?

-Andi
