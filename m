Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTKTXAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTKTXAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:00:10 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:15890 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263166AbTKTW4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:56:50 -0500
Date: Thu, 20 Nov 2003 23:56:47 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Eli Carter <eli.carter@inet.com>
Cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>,
       Patrick Beard <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Smartmedia 2.6.0-test9 problem.
Message-ID: <20031120225647.GB1756@win.tue.nl>
References: <bpcumv$v22$1@sea.gmane.org> <20031118174828.GA26450@axis.demon.co.uk> <3FBA9A6B.1040404@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBA9A6B.1040404@inet.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 04:17:15PM -0600, Eli Carter wrote:
> Nick Craig-Wood wrote:

> >The work-around I use is to "rmmod usb-storage ; modprobe usb-storage"
> >whenever I change memory card - this kicks the kernel into re-reading

> I've had this problem with 2.4 kernels as well, and use "unplug the 
> reader, rmmod, plug in the reader".  I reported this a long time ago, 

There is a command that tells the kernel to reread:
	blockdev --rereadpt /dev/foo

