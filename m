Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263756AbUDVAlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUDVAlG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 20:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbUDVAlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 20:41:06 -0400
Received: from codepoet.org ([166.70.99.138]:27060 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263752AbUDVAlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 20:41:04 -0400
Date: Wed, 21 Apr 2004 18:41:04 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Message-ID: <20040422004104.GA19969@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200404212219.24622.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404212219.24622.bzolnier@elka.pw.edu.pl>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 21, 2004 at 10:19:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> It is unsafe thing to do (no locking, no reference counting etc).
> Just remove module_exit() as it was done for IDE PCI drivers.

Out of curiosity, what would be needed to make it safe to unload
all ide modules from a system with a scsi rootfs?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
