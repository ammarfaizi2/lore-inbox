Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSKWBSK>; Fri, 22 Nov 2002 20:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSKWBSJ>; Fri, 22 Nov 2002 20:18:09 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:46798 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S266322AbSKWBSJ>; Fri, 22 Nov 2002 20:18:09 -0500
Date: Fri, 22 Nov 2002 17:29:06 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Cleanup usbnet zaurus support: kill crc32 table
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-usb-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Message-id: <3DDED9E2.6040107@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021121093621.GA221@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> crc32 is already in lib/crc32, no need to duplicate it... Please
> apply,

Thanks, removing that was on the list of stuff to do (also for
the 2.4.20 version of the patch).  I'll want to leave the comment
in there about how why a CRC32 seems to be desirable (guarding
against sa1100 bugs), since it's the only "minidriver" that needs
that kind of tweaks to the framing.

- Dave



