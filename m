Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbULAPAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbULAPAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULAPAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:00:31 -0500
Received: from smtp08.auna.com ([62.81.186.18]:23525 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261272AbULAPAJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:00:09 -0500
Date: Wed, 01 Dec 2004 15:00:08 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: cd burning, capabilities and available modes
To: Daniel Drake <dsd@gentoo.org>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1101908433l.8423l.0l@werewolf.able.es>
	<41ADF311.7030802@gentoo.org>
In-Reply-To: <41ADF311.7030802@gentoo.org> (from dsd@gentoo.org on Wed Dec  1
	17:36:33 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101913208l.8423l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.12.01, Daniel Drake wrote:
> Hi,
> 
> J.A. Magallon wrote:
> > As user:
> > werewolf:/store/tmp> cdrecord -dummy dev=ATAPI:1,0,0 *.iso
> > ...
> 
> Try with the real device name, e.g. dev=/dev/hdc
> 

The recommended mode is ATAPI, but anyways:

werewolf:/store/tmp> cdrecord -dummy dev=/dev/hdc *.iso
...
cdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).
cdrecord: WARNING: This causes a high risk for buffer underruns.
cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
cdrecord: Permission denied. WARNING: Cannot set priority using setpriority().
cdrecord: WARNING: This causes a high risk for buffer underruns.
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
WARNING ! Cannot gain SYS_RAWIO capability ! 
: Operation not permitted
Using libscg version 'schily-0.8'.
cdrecord: Warning: using inofficial libscg transport code version (warly-Mandrakelinux-scsi-linux-sg '@(#)scsi-linux-sg.c   1.83 04/05/20 Copyright 1997 J. Schilling').
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   : 
Vendor_info    : 'HL-DT-ST'
Identifikation : 'DVDRAM GSA-4120B'
Revision       : 'A102'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE 
Supported modes: 
cdrecord: Drive does not support TAO recording.
cdrecord: Illegal write mode for this drive.



--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam4 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


