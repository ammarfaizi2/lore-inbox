Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVDEIqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVDEIqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDEIqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:46:48 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:28333 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261634AbVDEIqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:46:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm1
Date: Tue, 5 Apr 2005 10:46:22 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org>
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504051046.23378.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 5 of April 2005 09:05, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
> 
> - x86 NMI handling seems to be bust in 2.6.12-rc2.  Try using
>   `nmi_watchdog=0' if you experience weird crashes.
> 
> - The possible kernel-timer related hangs might possibly be fixed.  We
>   haven't heard yet.
> 
> - Nobody said anything about the PM resume and DRI behaviour in
>   2.6.12-rc1-mm4.  So it's all perfect now?

Well, "my" problem with the PM suspend has turned out to be at least partially
hardware/BIOS-related, so it is not easily reproducible.  It is being worked on,
however, AFAICS, so I didn't reported it all over again.

There also is a problem with the ACPI battery driver, which is known to the
right people, too.

Anyway, the patches that cause these issues to appear have been identified
(they both come from the ACPI -bk tree).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
