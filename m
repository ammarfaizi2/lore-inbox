Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWHWA55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWHWA55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWHWA55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:57:57 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:3272 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932215AbWHWA54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:57:56 -0400
Date: Wed, 23 Aug 2006 09:57:36 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Bjo Breiskoll <bjo@nefkom.net>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Relay Subsystem the 2nd.
Message-ID: <20060823005736.GA8047@localhost.hsdv.com>
References: <002d01c6c645$9be1afe0$03b2a8c0@bjoserver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002d01c6c645$9be1afe0$03b2a8c0@bjoserver>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 01:49:29AM +0200, Bjo Breiskoll wrote:
> back to my question last week. I would like to implement a new kernel-modul
> with the ability to write data from kernelspace to userspace via the new
> relay subsystem. The less info from block/blktrace.c is insufficient
> unfortunately. The userspace-program should be able to "listen" to the
> kernel-modul if there is new data written. My first Implementation with data
> exchange over copy_to_user() and a char-device is insufficient. So i need an
> hint for something like blocked-IO for relay-files. Is this possible with
> the new relay-subsystem?
>  
Is there something insufficient with poll() on relay files?
