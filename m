Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWJWEMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWJWEMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWJWEMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:12:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:11248 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751444AbWJWEMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:12:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J6HUjOJV5A7+dPoAV7L8SqPNlxJQtxKMz+C4DyFiCKrM6Pzj72UCiF2rpSPM8kCvoBKzePFi+AdBcx5TQQZb3oIsGZsfpJkEi1+hMJUkYtDcR0H6vrWfiw5cWkv5CvtCpAx+j8EHL+1EOAhqqdukSIq/FDTx7nlmdhEIzZm35DU=
Message-ID: <b6a2187b0610222112mc6450c4jbda57b1ed7727878@mail.gmail.com>
Date: Mon, 23 Oct 2006 12:12:05 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc2 tg3 cannot find proper pci device base address
In-Reply-To: <b6a2187b0610222020o5ed1e463k7f5b7c133b804293@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0610222020o5ed1e463k7f5b7c133b804293@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this error on with linux 2.6.19-rc2 with tg3 module, even
with patching to v3.66 ...

tg3.c:v3.67 (October 18, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
tg3: Cannot find proper PCI device base address, aborting.
ACPI: PCI Interrupt for device 0000:02:00.0 disabled

The last version 2.6.18-rc2 works fine.

Jeff.
