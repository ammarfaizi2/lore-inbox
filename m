Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTJ3OYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 09:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTJ3OYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 09:24:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48594 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262566AbTJ3OYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 09:24:14 -0500
Message-ID: <3FA11F00.9020000@pobox.com>
Date: Thu, 30 Oct 2003 09:24:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaheed <srhaque@iee.org>
CC: linux-kernel@vger.kernel.org, michael@labuschke.de
Subject: Re: WG:  EIO DM-8401H ATA133 IDE Controller Card ( Silicon Image
 Chip ?!?)
References: <200310301312.52793.srhaque@iee.org>
In-Reply-To: <200310301312.52793.srhaque@iee.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaheed wrote:
> Interestingly, EXACTLY the same thing happened to me. I actually bought a 
> vanilla IDE controller for a spare disk, and in what showed up the 
> documentation claimed it was a DM-8401R, but lspci shows what you see: and 
> IT8212.
> 
> The answer was to get the good stuff from here:
> 
> http://www.iteusa.com/productInfo/Download.html#IT8212%20ATA133%20Controller
> 
> The driver install was a doddle (well documented, and easy to apply Mandrake 
> 9.1 instructions to 9.2). For heavens sake: these guys even provide the specs 
> online. And the driver seems to work, though I am not stressing it.


Neat.  Even though it's a SCSI driver, it's very definitely a standard 
IDE controller, which should be easy for Bart or somebody to add to 
drivers/ide ...

	Jeff



