Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUI2XVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUI2XVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269166AbUI2XVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:21:46 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:34443 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269182AbUI2XUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:20:49 -0400
Subject: Re: nforce2 bugs?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: white phoenix <white.phoenix@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <e2ae0e3b04092915427fcff604@mail.gmail.com>
References: <e2ae0e3b04092915427fcff604@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096496263.16768.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 23:17:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 23:42, white phoenix wrote:
> [x86] fix lockups with APIC support on nForce2

Looks reasonable (anyone from Nvidia care to ack any of these)

> Add PCI quirk to disable Halt Disconnect and Stop Grant Disconnect
> (based on athcool program by Osamu Kayasono).

Is this always safe - if not why does the BIOS not do it.


APIC one I don't have enough background on

