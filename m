Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSFWUnU>; Sun, 23 Jun 2002 16:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSFWUnT>; Sun, 23 Jun 2002 16:43:19 -0400
Received: from out013pub.verizon.net ([206.46.170.44]:12267 "EHLO
	out013.verizon.net") by vger.kernel.org with ESMTP
	id <S317115AbSFWUnT>; Sun, 23 Jun 2002 16:43:19 -0400
Message-ID: <3D163345.4080708@verizon.net>
Date: Sun, 23 Jun 2002 16:44:53 -0400
From: Emre Tezel <emre.tezel@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19-10, Kernel Parameter, IDE ATAPI Floppy
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am running kernel 2.4.19-pre10. I have an internal ATAPI Zip drive 
connected as primary slave to device file /dev/hdb. I want to use the 
ide-floppy driver in stead of the scsi emulation (ide-scsi), but kernel 
always picksup the ide-scsi.

Is there a way, such as kernel parameter, so that the kernel uses the 
ide-floppy in stead. Can I do things like,

hdb=floppy

or

floppy=hdb

or

hdb=ide-floppy /* <- This did not work */

Thank you all in advance,
Emre

