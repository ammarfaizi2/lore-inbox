Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTDLPT2 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 11:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTDLPT2 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 11:19:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31659
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263311AbTDLPT2 (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 11:19:28 -0400
Subject: Re: toshiba 1605/1625 hibernation issues [problem with ALi 15x3
	driver]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trelane@digitasaru.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030412033232.GB887@digitasaru.net>
References: <20030412033232.GB887@digitasaru.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050157975.16006.38.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Apr 2003 15:32:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-12 at 04:32, Joseph Pingenot wrote:
> Well, actually, it's a workaround, not a fix.
> Remove support for the ALi 15x3 chipset support (under IDE drivers).  Just
>   use the generic.

You probably need to hdparm -d0 /dev/hda before suspending and hdparm
-d1 after resuming. I would guess your BIOS doesnt know how to keep the
IDE state straight.

