Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVBUIil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVBUIil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVBUIik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:38:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62164 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261922AbVBUIiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:38:12 -0500
Message-ID: <42199DD9.10807@pobox.com>
Date: Mon, 21 Feb 2005 03:37:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
References: <9e47339105022023242e2fd9ce@mail.gmail.com>
In-Reply-To: <9e47339105022023242e2fd9ce@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> I haven't been able to come up with a reliable way to call a user
> space reset program from a driver's probe function except with an
> in-kernel emu86. Is there another way? I'd also like to try an find a
> solution that doesn't need to modify the 73 existing framebuffer
> drivers.


You either need to execute the video BIOS to initialize the hardware 
registers, or initialize the hardware registers themselves.

	Jeff

