Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbULaAm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbULaAm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbULaAm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:42:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:42919 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261798AbULaAm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:42:27 -0500
Subject: Re: ide problem...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Micha <micha-1@fantasymail.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412292213.34517.micha-1@fantasymail.de>
References: <200412292213.34517.micha-1@fantasymail.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104429369.2446.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Dec 2004 23:38:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-29 at 21:13, Micha wrote:
> I got an error reading a dvd with 2.6.9 and ide interface. Switching to 
> ide-scsi for the dvd-rom made the dvd work. Is this an ide-error? I think 
> libdvdread should not know wether it's reading a scsi or a ide device...

The ide-cd driver in the base 2.6.x kernel has some quite serious bugs.
Always use ide-scsi if you can. I would be interested to know if you hit
the same problems with 2.6.10-ac1 and if so what is logged.

