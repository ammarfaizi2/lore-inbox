Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTDVQYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTDVQYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:24:06 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:31641 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263279AbTDVQYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:24:05 -0400
Message-ID: <3EA56F77.7030805@blue-labs.org>
Date: Tue, 22 Apr 2003 12:36:07 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: scsi HBA driver sym53c8xx didn't set a release method, please fix
 the template
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 930; timestamp 2003-04-22 12:36:10, message serial number 4413
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1> scsi HBA driver sym53c8xx didn't set a release method, please fix the 
template

2> Please use the 'usbfs' filetype instead, the 'usbdevfs' name is 
deprecated.

3> request_module: failed /sbin/modprobe -- snd-card-0. error = -16


More long outstanding dmesg information.  For #2, I have 'usbfs' in my 
fstab but this is nonsensical, init hasn't even been started yet. For 
#3, all my sound is compiled in and just after this line there is a 
[too] plentiful ALSA cs46xx output :)

david




