Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTFAIXs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 04:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTFAIXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 04:23:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:57102 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261743AbTFAIXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 04:23:47 -0400
Date: Sun, 1 Jun 2003 10:36:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Daniel Podlejski <underley@underley.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx problem
Message-ID: <20030601083656.GI21673@alpha.home.local>
References: <20030531165945.GA5561@witch.underley.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531165945.GA5561@witch.underley.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 06:59:45PM +0200, Daniel Podlejski wrote:
 
> (scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
>   Vendor: IBM       Model: DPSS-318350N      Rev: S96H
>   Type:   Direct-Access                      ANSI SCSI revision: 03

<...>

> (scsi0:A:0): 980KB/s transfers (0.980MHz, offset 255)
> scsi0: target 0 using 8bit transfers
> (scsi0:A:0): 3.300MB/s transfers
> scsi0: target 0 using asynchronous transfers

Hmmm that makes quite a difference ! I didn't understand what happened between
these two outputs. Also, did you try with Justin's latest version of the driver:

   http://people.freebsd.org/~gibbs/linux/SRC/

It fixed many problems for several of us.

Regards,
Willy

