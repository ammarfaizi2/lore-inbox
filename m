Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUB2Smu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 13:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUB2Smu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 13:42:50 -0500
Received: from [80.72.36.106] ([80.72.36.106]:29587 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262099AbUB2Smt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 13:42:49 -0500
Date: Sun, 29 Feb 2004 19:42:45 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Robbert Haarman <lkml@inglorion.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 Build System and Binary Modules
In-Reply-To: <20040229183143.GA8057@shire.sytes.net>
Message-ID: <Pine.LNX.4.58.0402291940110.22146@alpha.polcom.net>
References: <20040229183143.GA8057@shire.sytes.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004, Robbert Haarman wrote:

> Hello list,
> 
> Excuse me for not finding this if it has been asked before. Please Cc any answers, as I am not subscribed to this list.
> 
> I am trying to port a driver for the Realtek 8180 wireless ehternet controller from 2.4 to 2.6. The module comes as a binary-only object file with some sources that can be adapted to fit the specific kernel. My problem is that I can't figure out how to get the 2.6 kernel to include the binary part (it's in a .o file). The new build system does a little too much magic - compiling the module from source to .ko without giving me a chance to sneak in the binary code. How do I get it to link in the .o file, without making it look for the like-named .c file?
> 
> Cheers,
> 
> Robbert Haarman

I do not know if it will help You, but take a look at how makefile of new 
nvidia driver is built... (patches from minion.de or newest driver from 
nvidia.com)

Grzegorz Kulewski

