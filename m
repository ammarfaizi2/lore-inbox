Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbTDRQOL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbTDRQMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:12:30 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:62725 "EHLO
	fw.vanvergehaald.nl") by vger.kernel.org with ESMTP id S263139AbTDRQMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:12:12 -0400
Date: Fri, 18 Apr 2003 17:49:12 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
Message-ID: <20030418154911.GA16046@hout.vanvergehaald.nl>
References: <20030418014536.79d16076.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030418014536.79d16076.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 01:45:36AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm4/
> 
> . A bunch of anticipatory scheduler patches.
> 
>   For the first time ever, AS is working well with both IDE and SCSI
>   under all the usual tests.
> 
>   It works just fine on SCSI with zero TCQ tags, and with four TCQ tags. 
>   At eight tags, read-vs-write performace is starting to measurably drop off.
>   At 32 tags it is about 2000x slower than at zero or four tags.
> 
>   My recommendation, as always, is to disable SCSI TCQ completely.  If you
>   really must, set it to four tags.

What about drivers that bypass de SCSI layer?
I administer a server with a Mylex RAID controller (DAC960)...

Regards,
Toon.
