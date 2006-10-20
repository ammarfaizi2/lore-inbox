Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992636AbWJTO5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992636AbWJTO5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992637AbWJTO5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:57:12 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:8456 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S2992636AbWJTO5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:57:11 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: cbou@mail.ru
Subject: Re: 2.6.19-rc2-mm2
Date: Fri, 20 Oct 2006 16:57:59 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610201339.49190.m.kozlowski@tuxland.pl> <20061020133204.GA25204@localhost>
In-Reply-To: <20061020133204.GA25204@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610201657.59168.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> > 	I installed 2.6.19-rc2-mm2 without kernel debugging options enabled
> > first. The output below is what I saw when the kernel started. Then I
> > enabled debugging and system hangs with oops with no trace in the logs.
> > It is not easily repeatable though. It happens from time to time.
>
> Is that patch helps?

Sorry but it did not help. Both errors (pcmcia ioctl and drm) are still there. 
It is hard to trigger these errors when debugging is enabled. I did something 
like 10 or more reboots with no error seen. When I recompiled the kernel 
without debugging support almost every reboot triggers error. The good thing 
is that beside these errors system is usable and wifi works just fine.

Regards,

	Mariusz Kozlowski
