Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVEUBIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVEUBIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 21:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEUBIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 21:08:17 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:31201 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261203AbVEUBIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 21:08:11 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [2.6 patch] remove the obsolete raw driver]
Date: Fri, 20 May 2005 18:07:59 -0700
User-Agent: KMail/1.8
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050521001925.GQ5112@stusta.de> <20050521004333.GA20174@krispykreme>
In-Reply-To: <20050521004333.GA20174@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505201808.00055.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 20, 2005 5:43 pm, Anton Blanchard wrote:
> > Since kernel 2.6.3 the Kconfig text explicitely stated this driver
> > was obsolete.
> >
> > It seems to be time to remove it.
>
> Disagree. We need someone to benchmark and prove O_DIRECT on the raw
> device isnt a performance regression first.

I don't have data on hand, but I recall seeing O_DIRECT on block devices 
(at least SCSI ones), attaining something very close to line rate, and 
scaling quite well as I/O was added.

Jesse
