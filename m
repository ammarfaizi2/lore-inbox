Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWFYLGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWFYLGM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWFYLGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:06:11 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:9656 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932353AbWFYLGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:06:10 -0400
Date: Sun, 25 Jun 2006 13:05:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read
 atip wiith cdrecord
In-Reply-To: <20060624144739.78bde590.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0606251304450.28911@yvahk01.tjqt.qr>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
 <20060624144739.78bde590.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>            Summary: kernel hangs when trying to read atip wiith cdrecord
>>     Kernel Version: 2.6.16.1

>> Most recent kernel where this bug did not occur: 2.6.16.1 (yes, the 
>> same version - it works with my dvd-burner, but not with my cd-burner), 
>> the 2.4 series worked with both, but there I have been using ide-scsi)

Can you try a newer version and/or (or both) with an original cdrecord (if 
not already done so) or cdrecord-prodvd?

>> Distribution: Mandriva 9.0 based

>> cdrtools 2.01.01a10

>> Steps to reproduce:
>> I simply try to use "cdrecord dev=ATAPI:1,0,0 -atip" as root.
>> # cdrecord dev=ATAPI:1,0,0 -atip

Try -dev=/dev/hdX



Jan Engelhardt
-- 
