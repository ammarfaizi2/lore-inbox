Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUBVKao (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 05:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUBVKao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 05:30:44 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:63239 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261220AbUBVKan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 05:30:43 -0500
Date: Sun, 22 Feb 2004 10:30:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Manish Lachwani <lachwani@pmc-sierra.com>, Greg KH <greg@kroah.com>
Subject: Re: i2c-yosemite
Message-ID: <20040222103036.A29210@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	LM Sensors <sensors@stimpy.netroedge.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Manish Lachwani <lachwani@pmc-sierra.com>, Greg KH <greg@kroah.com>
References: <20040222104106.714de992.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040222104106.714de992.khali@linux-fr.org>; from khali@linux-fr.org on Sun, Feb 22, 2004 at 10:41:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 10:41:06AM +0100, Jean Delvare wrote:
> If everyone reimplements what already exists, the kernel is likely to go
> bigger with no benefit. Also, you won't be able to use all user-space
> tools that already exist, and will also have to write specific chip
> drivers for the chips present on the yosemite bus, although these
> drivers (Atmel 24C32 EEPROM and MAX 1619) already exist.
> 
> Please explain to us why you cannot/don't want to use the existing i2c
> subsystem.

Yupp.  While we're at it what should we do with the i2c reimplementations
in alsa and dvb?

