Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWEXLIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWEXLIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWEXLIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:08:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6109 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932684AbWEXLIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:08:37 -0400
Subject: Re: Q: how to send ATA cmds to USB drive?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605240922.k4O9MlXW007991@wildsau.enemy.org>
References: <200605240922.k4O9MlXW007991@wildsau.enemy.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 24 May 2006 12:22:33 +0100
Message-Id: <1148469753.4753.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-24 at 11:22 +0200, Herbert Rosmanith wrote:
> But now I also have to support USB harddisks from the same company.
> The USB harddisk uses the same set of ATA commands as the IDE harddisk,
> well, at least that's what I suppose.

USB storage is a sort of 'pigdin' SCSI. You send SCSI commands to the
USB storage device but you may find anything too clever breaks.


