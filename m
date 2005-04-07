Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVDGAkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVDGAkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 20:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVDGAkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 20:40:32 -0400
Received: from mail.aei.ca ([206.123.6.14]:24008 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262359AbVDGAk1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 20:40:27 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm1
Date: Wed, 6 Apr 2005 20:40:21 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org>
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504062040.21393.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 April 2005 03:05, Andrew Morton wrote:
> - x86 NMI handling seems to be bust in 2.6.12-rc2.  Try using
>   `nmi_watchdog=0' if you experience weird crashes.
> 
> - The possible kernel-timer related hangs might possibly be fixed.  We
>   haven't heard yet.
> 
> - Nobody said anything about the PM resume and DRI behaviour in
>   2.6.12-rc1-mm4.  So it's all perfect now?
> 
> - Various fixes and updates.  Nothing earth-shattering.

This refuses to boot here.  It dies when assigning the EHCI driver.  The mb is an MSI-7030 K8N Neo Platinium
based on a nForce 3 250Gb Chipset (x86_64).  I`ve been on vacation - the last kernel tried was 11-mm3 which
booted fine but refuses to use all the usb ports supplied by the system (two work, three do not all using low 
speed).

Any ideas what might be happening?
Ed Tomlinson 

