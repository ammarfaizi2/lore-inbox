Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTIPRIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTIPRIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:08:20 -0400
Received: from infres.enst.fr ([137.194.192.1]:57592 "EHLO infres.enst.fr")
	by vger.kernel.org with ESMTP id S262061AbTIPRIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:08:19 -0400
Date: Tue, 16 Sep 2003 19:08:17 +0200 (MEST)
From: Ramon Casellas <casellas@infres.enst.fr>
X-X-Sender: casellas@gervaise.enst.fr
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
In-Reply-To: <Pine.LNX.4.44.0309160949140.26788-100000@cherise>
Message-ID: <Pine.SOL.4.40.0309161905530.7293-100000@gervaise.enst.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Patrick Mochel wrote:

>
> Ok, that's almost expected behavior.
Good to know :)

>
> I cannot explain why the LCD stays on, besides the fact that something on
> the ACPI side of things is not working correctly. Though, it appears to be
> performing the entire suspend/resume cycle.

:? It's possible. ACPI is *the other missing part* :) There are some
issues with detecting the Embedded Controller and AE_TIMES in latest IBM
thinkpads, but things are getting better.


> Drivers are still an issue. The current work around is to try removing all
> modules before suspending. There is also an issue with reinitializing the
> ACPI IRQ routing links, which will be addressed shortly.

Good to know (part II)


> to handle high pages yet. It will be addressed, but probably not for
> another few weeks.
>

Good things come to those who wait. I'll be trying APM as well... Let me
know if you want me to test something/patches, etc.

Thanks for your time,
R.


