Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUAUWS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUAUWS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:18:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:1693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266009AbUAUWS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:18:28 -0500
Date: Wed, 21 Jan 2004 14:18:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Georg C. F. Greve" <greve@gnu.org>
cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: PROBLEM: ACPI freezes 2.6.1 on boot
In-Reply-To: <m3d69dhukz.fsf@reason.gnu-hamburg>
Message-ID: <Pine.LNX.4.58.0401211414450.2123@home.osdl.org>
References: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
 <m3d69dhukz.fsf@reason.gnu-hamburg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jan 2004, Georg C. F. Greve wrote:
> 
> Just tried removing the outb() call both from plain vanilla 2.6.1 and
> one with the latest ACPI patch. No change. The system freezes with the
> same message at the same point during bootup.
> 
> Any other ideas?

Nope. It would probably help to enable ACPI debugging, and see if there 
are any other messages printed.

And it would also help to go back to the working kernel (somebody said 
2.6.1-rc1 worked), and try to see what the differences are and what is the 
first kernel that breaks. -rc2? -rc3? or 2.6.1-final?

		Linus
