Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVCGXiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVCGXiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVCGXgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:36:01 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:1767 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261916AbVCGXE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:04:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mT2rxW67zh7R1MKMq18qPmF8wpK98V4B2vxaD29N4+f6N57Na9VaHaRJfdxLzkjczxRcCz3jGr6ydT+t+tKi7WCv/oMOhVhUd3dfzE1+NKinyvxGTK5BUwByb3SwNNawmAAvuZhSRw6VIBLkSU67kSBcSLW2YOOKmCHhIY1xtYU=
Message-ID: <9e47339105030715034a8f8ff9@mail.gmail.com>
Date: Mon, 7 Mar 2005 18:03:57 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH] PCI bridge driver rewrite (rev 02)
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1110234742.2456.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110234742.2456.37.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about a bridge driver for ISA LPC bridges? That would also
provide a logical place to hang serial ports, floppy, parallel port,
ps2 port, etc. Things in /sys/bus/platform are really attached to the
LPC bridge.

-- 
Jon Smirl
jonsmirl@gmail.com
