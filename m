Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVHDLPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVHDLPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVHDLPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:15:33 -0400
Received: from [81.2.110.250] ([81.2.110.250]:64958 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262477AbVHDLPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 07:15:31 -0400
Subject: Re: IDE disk and HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Tennert <O.Tennert@science-computing.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508040914.10810.tennert@science-computing.de>
References: <200507221417.04640.tennert@science-computing.de>
	 <1122043638.9478.14.camel@localhost.localdomain>
	 <200508040914.10810.tennert@science-computing.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Aug 2005 12:41:27 +0100
Message-Id: <1123155687.6278.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-04 at 09:14 +0200, Oliver Tennert wrote:
> partitioning and filesystems. The point is, IF there is an HPA, there MIGHT 
> be a partitioning scheme and some filesystems on the disk which rely on the 
> size of disk being the native size MINUS the HPA.

Thats fine, Linux is quite happy with such a partitioning table.

> Also there might be some contents in the HPA which is vulnerable to deletion 
> if exposed to the OS in such a transparent way.

By opening the raw disk file yes, but that is not a big concern

> Why is the HPA not just left alone?

As I said before - because in most cases the HPA is used just to fool an
old bios into booting a large disk. 

