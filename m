Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUIZSZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUIZSZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 14:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIZSZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 14:25:40 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:63500 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S261474AbUIZSZj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 14:25:39 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.9rc2+bk hangs at: ACPI: IRQ9 SCI: Level Trigger or Checking 'hlt' instruction... OK.
Date: Sun, 26 Sep 2004 20:23:48 +0200
User-Agent: KMail/1.7
References: <200409260518.26590.arekm@pld-linux.org>
In-Reply-To: <200409260518.26590.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409262023.48626.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 of September 2004 05:18, Arkadiusz Miskiewicz wrote:
> My kernel (2.6.9rc2+cset-20040926_0006) hangs at:
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> ACPI: IRQ9 SCI: Level Trigger.
>
> Previous working kernel running here was 2.6.9rc2+20040914_1622.
More information.

This is unrelated to ACPI since kernel compiled without ACPI also hangs at:
,,Checking 'hlt' instruction... OK.''.

Something else is broken. Two other people confirmed the problem for me.
-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
