Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbUJXIbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUJXIbC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 04:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUJXIbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 04:31:01 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:34253 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261386AbUJXIaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 04:30:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Fvoy902FKAKb/eviSvwWAc9R3DHk8x6Q6r4xrvsqhyL1qrm5xczOL1/PIH7LYBtpIqU8ZZ75ACHNPzLVIT2ypF8NDaTDJKdi9CIgRsrljPku/HVkxrvIJFieZ70Ml49ST6bGpPhEYePNkAS9uYr4PetGMLcQQOmhEa+oCetqdHU=
Message-ID: <b98c6b1a041024013067e06b0a@mail.gmail.com>
Date: Sun, 24 Oct 2004 16:30:55 +0800
From: mike lewis <lachlanlewis@gmail.com>
Reply-To: mike lewis <lachlanlewis@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4 stability issues
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I wouldn't consider my self a complete newb, but you may, so feel free
to direct me to the newb list if this is where it should be.

I've recently come across (saved and purchased) a dvb card which is
only supported by cvs linux-dvb of a few days ago, which in turn
willonly compile on 2.6.9-rc4.  So I upgraded my kernel to 2.6.9-rc4 a
week ago, and now I have stability issues and I'm not sure where to
turn.  I looked through the changelog from 2.6.8 to 2.6.9 and say a
lot a ACPI changes, so I turned acpi off in my kernel to see if this
was the source.. It is not..

The device is remote, so I can only ssh / telnet in to debug.  I'm
wondering what steps I can take to establish why this particular
flavour of kernel is not happy on my system.   One issue I have, is
how to establish the cause of the system freezes?  I'm assuming a
segfault of some kind or another would be logged somewhere, but they
do not appear in /var/log/messages..

Is there any way to log the segfault cause to post/investigate?

Mick
