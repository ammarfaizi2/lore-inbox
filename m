Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVGFT6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVGFT6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVGFT4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:21 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:62379 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262158AbVGFPiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:38:20 -0400
Date: Wed, 6 Jul 2005 08:38:14 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Bhagyashri Bijwe <bhagyashri.bijwe@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bios interaction with linux kernel after uncompression.
Message-Id: <20050706083814.071230ca.rdunlap@xenotime.net>
In-Reply-To: <b386e6140507052332616b131f@mail.gmail.com>
References: <b386e6140507052332616b131f@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005 12:02:26 +0530 Bhagyashri Bijwe wrote:

| Hi,
|      During bootstrapping,  bios provides services like video ,hard
| drive services, memory sizing, PCI table to linux kernel.
|      After uncompression of kernel , Does linux kernel have any
| interaction with bios?
|     I know that most of work is done by linux device driver. 
|     What is dependency of running linux on bios ?
|   Thanks in advance,

As little as possible after boot/init.

That means that BIOS is used for APM mode selections
if APM is being used and for ACPI state-switching.
Oh, I guess we have to acknowledge that hidden SMI code
also, but Linux doesn't use it AFAIK, it's just there
and being executed.

Those are all that I know of before being fully awake.

---
~Randy
