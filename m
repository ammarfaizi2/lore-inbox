Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbTE2TTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTE2TTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:19:20 -0400
Received: from bork.hampshire.edu ([206.153.194.35]:11242 "EHLO
	bork.hampshire.edu") by vger.kernel.org with ESMTP id S262528AbTE2TTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:19:20 -0400
Date: Thu, 29 May 2003 15:32:37 -0400 (EDT)
From: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
X-X-Sender: josiah@bork.hampshire.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: siimage driver status
In-Reply-To: <1054220163.20725.96.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305291531270.23056-100000@bork.hampshire.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That might be nice - would it be possible for you to send me a patch? Or 
is there something I can pass to the kernel at boottime that will make it 
enable DMA? I've been experimenting with ide2=autotune hde=autotune etc 
and that doesn't seem to be working.
Thanks so much,
	-Josiah


On 29 May 2003, Alan Cox wrote:
<SNIP>
> Now I suppose I just have to figure out how to make that work on boot 
> (perhaps just to make the BIOS put them in DMA mode)

One thing I might do is just make the driver ignore the bios policy for
disk devices. 

