Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTFDS2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTFDS2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:28:04 -0400
Received: from mail017.syd.optusnet.com.au ([210.49.20.175]:7605 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261323AbTFDS2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:28:03 -0400
Date: Thu, 5 Jun 2003 04:40:08 +1000
To: Jeremy Salch <salch@tblx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Access past end of device
Message-ID: <20030604184008.GB9732@cancer>
References: <20030604170215.GA9732@cancer> <002001c32abe$10a18700$9fdeae3f@TBLXM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002001c32abe$10a18700$9fdeae3f@TBLXM>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 12:23:50PM -0500, Jeremy Salch wrote:
> I did a fdisk on the device /dev/sda  and it found no bad blocks.  

That's a good thing - be greatful :)

> I was given the suggestion from one person it sounds like a kernel bug since
> redhat patches their kernels soo much.

Could be, try a kernel.org kernel and see if the problem persists. If it goes away, file a bug report with redhat. I would think fdisk would come up with an error on a corrupt partition map, so if it doesn't then ur probably looking at some oddity... try the kernel.org kernel :)

- stew 
