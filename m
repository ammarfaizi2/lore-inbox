Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTEFMBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTEFMBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:01:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59558
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262609AbTEFMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:01:34 -0400
Subject: Re: Binary firmware in the kernel - licensing issues.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB79ECE.4010709@thekelleys.org.uk>
References: <3EB79ECE.4010709@thekelleys.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052219735.28796.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 12:15:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 12:38, Simon Kelley wrote:
> This software is copyrighted by and is the sole property of Atmel
> Corporation.  All rights, title, ownership, or other interests
> in the software remain the property of Atmel Corporation.  This
> software may only be used in accordance with the corresponding
> license agreement.  Any un-authorized use, duplication, transmission,
> distribution, or disclosure of this software is expressly forbidden. 

So you can't distribute it at all unless there is other paperwork
involved.

> Given the current SCO-IBM situation I don't want to be responsible for
> introducing any legally questionable IP into the kernel tree.
> 
> This situation must have come up before, how was it solved then?

The easiest approach is to do the firmware load from userspace - which
also keeps the driver size down and makes updating the firmware images
easier for end users.

(Debian as policy will rip the firmware out anyway regardless of what
Linus does btw)

The hotplug interface can be used to handle this.

