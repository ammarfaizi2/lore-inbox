Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTEHLzE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTEHLzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:55:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65413
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261409AbTEHLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:54:42 -0400
Subject: Re: 2.5.69, IDE problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Ford <david+powerix@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB9F541.7060008@blue-labs.org>
References: <3EB9F541.7060008@blue-labs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052392128.10037.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 12:08:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 07:12, David Ford wrote:
> hda: dma_timer_expiry: dma status == 0x24
> drivers/ide/ide-io.c:108: spin_lock(drivers/ide/ide.c:c04fb648) already 
> locked by drivers/ide/ide-io.c/948
> drivers/ide/ide-io.c:990: spin_unlock(drivers/ide/ide.c:c04fb648) not locked

This was fixed in the 2.4-ac tree. I guess the 2.5 stuff hasn't picked
up the changes yet

