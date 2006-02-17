Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWBQGDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWBQGDa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 01:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWBQGDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 01:03:30 -0500
Received: from smtp-out1.Berkeley.EDU ([128.32.61.106]:43439 "EHLO
	smtp-out1.berkeley.edu") by vger.kernel.org with ESMTP
	id S932348AbWBQGD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 01:03:29 -0500
Message-ID: <43F566A7.4050801@berkeley.edu>
Date: Thu, 16 Feb 2006 22:01:11 -0800
From: "Brandon J. Lewis" <brandon_lewis@berkeley.edu>
Reply-To: brandon_lewis@berkeley.edu
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Assertion fails with ata_piix and libata on ibm thinkpad t43 when
 writing to cdrom
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To whom it may concern,

Just updated to 2.6.16rc3 in order to get my cdrw drive working on my
thinkpad and noticed the following issue which may be of interest to 
someone. I am using the ata_piix module with the boot option 
"libata.atapi_enabled=1"

The following message is printed many times in the syslog and the output
of dmesg when burning cdrw's with cdrecord:

localhost kernel: Assertion failed! qc->n_elem >
0,drivers/scsi/libata-core.c,ata_fill_sg,line=2573

I am using debian sarge, cdrecord version Cdrecord-Clone 2.01.01a01.

command issued was
"cdrecord -tao -pad -audio -nofix <filename>"

Thanks for your time.

Sincerely,

Brandon Lewis
