Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUKJTly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUKJTly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbUKJTlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:41:12 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:466 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262117AbUKJTku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:40:50 -0500
Subject: Re: 2.6 vs 2.4: pxe booting system won't restart
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Jackson <notiggy@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <fb20c214041110103647fc6b51@mail.gmail.com>
References: <fb20c214041110103647fc6b51@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100111849.20555.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 18:37:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-10 at 18:36, Brian Jackson wrote:
> I'm having a problem with 2.6 (many versions), and my Via Epia M10000
> not rebooting correctly. 2.4 works fine. The problem is after the
> computer restarts, and the pxe stuff from the bios tries to do it's
> thing, it fails. I get the following error:
> PXE_M0F: Exiting Intel PXE ROM.
> 
> Then the bios tries to fallback to other means of booting, and there
> are none. Anybody got any clues where to start looking for fixes?

Remove the kernel code that powers down the ethernet chip. If that works
then poke VIA.

