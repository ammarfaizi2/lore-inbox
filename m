Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVCPFbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVCPFbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVCPFbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:31:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:62666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262527AbVCPFb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:31:27 -0500
Date: Tue, 15 Mar 2005 21:31:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
Message-Id: <20050315213110.75ad9fd5.akpm@osdl.org>
In-Reply-To: <4237C40C.6090903@sbcglobal.net>
References: <4237A5C1.5030709@sbcglobal.net>
	<20050315203914.223771b2.akpm@osdl.org>
	<4237C40C.6090903@sbcglobal.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert W. Fuller" <orangemagicbus@sbcglobal.net> wrote:
>
>  I never actually saw it work until I added the noapic option to the 
>  2.6.11.2 boot.  Now I can usually my USB mouse!  Of course the downside 
>  to specifying noapic is only one CPU is servicing interrupts on my SMP 
>  system.

Oh, OK.  I was just wondering whether this was an actual regression.  I
guess as it's an old machine and you have a workaround, we have other
things to be working on.

It would be nice to fix though.

>  It certainly doesn't work under 2.4.28, but I haven't tried specifying 
>  noapic to that kernel.  Would that be useful information?

Probably not.
