Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbUDBR4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 12:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbUDBR4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 12:56:23 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:55428 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S264137AbUDBR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 12:56:21 -0500
Message-ID: <406DA946.7040202@backtobasicsmgmt.com>
Date: Fri, 02 Apr 2004 10:56:22 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>,
       Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
References: <406D65FE.9090001@broadnet-mediascape.de> <6uad1uv7kr.fsf@zork.zork.net> <20040402144216.A12306@flint.arm.linux.org.uk> <20040402165941.GA29046@kroah.com> <20040402181630.B12306@flint.arm.linux.org.uk>
In-Reply-To: <20040402181630.B12306@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> (b) have kconfig tell you why you can't turn off the option.
> 
> Silently preventing options being turned off with no obvious reason
> is a pretty major misfeature.

It's even worse than that; with USB_STORAGE enabled, CONFIG_SCSI doesn't 
even show an option selection box, so it's not even obvious that it _is_ 
an option, rather than a comment.
