Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267867AbUG3XiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267867AbUG3XiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 19:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUG3XiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 19:38:07 -0400
Received: from the-village.bc.nu ([81.2.110.252]:31399 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267868AbUG3XiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 19:38:05 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091226922.5083.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 30 Jul 2004 23:35:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-07-30 at 20:11, Todd Poynor wrote:
> IDE initialization and probing makes numerous calls to sleep for 50
> milliseconds while waiting for the interface to return probe status and
> such. 

Please make it taint the kernel if you do that so we can ignore all the
bug reports. That or justify it with a cite from the ATA standards ?

