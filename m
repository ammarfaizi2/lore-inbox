Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWB1TK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWB1TK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWB1TK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:10:27 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:39855 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932425AbWB1TK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:10:26 -0500
Message-ID: <4404AD18.2070208@soleranetworks.com>
Date: Tue, 28 Feb 2006 13:05:44 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [FREELOADER ANNOUNCE] DSFS patches for Linux-2.6.9-22 (Red Hat ES4
 and WS4) Posted
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a FREELOADER Release:

Patches and modified kernel tar.gz files can be downloaded from 
ftp.soleranetworks.com. 

These patches are posted and provided IAW the terms of the GNU Public 
License version 2 **ONLY**
(Hope that one made Linus smile).

Several problems to report:

the 3w-9xxx driver reports bogus SGL list errors unles you upgrade the 
kernel tree with
the latest version.  It's in the patch.  There are also some receiver 
lockup problems with
the e1000 Ethernet driver is you cross 64K boundries during DMA.  Fixed 
both in
the patches.  The e1000 problem I introduced with my drivers mods.  The 
3Ware
9xxx problems need an updated driver. 

Someone needs to make certain the 3w-9xxx.c file is current.  2.6.11, 
2.6.12, and 2.6.13
all have this bogus error unless the driver gets updated.

Jeff

NOTE:

"Cry me a river" (tm) is an unregistered common law trademark of Linus 
Torvalds.
"The Cure for Stupidity is Silence" (tm) is an unregistered common law 
trademark of Jeff Merkey.


