Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVEEOvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVEEOvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 10:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVEEOvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 10:51:13 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:13460 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262119AbVEEOvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 10:51:11 -0400
Subject: Re: kernel panics with ide/pci hpt372
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tobias Margitan <t.margitan@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4278E261.1080503@t-online.de>
References: <4278E261.1080503@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115304588.19844.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 May 2005 15:49:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-05-04 at 15:55, Tobias Margitan wrote:
> Problem Description: since 2.6.8 I get Kernel Panics in module hpt372 wich is
> included in hpt366 driver

HPT372N controllers don't work with Linux because the tuning code in the
driver needs rewriting. It might randomly sometimes work with the wrong
timings with the old old driver or it might eat all your data or more
likely some nasty combination of the two.

Alan

