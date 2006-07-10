Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422705AbWGJRDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWGJRDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422707AbWGJRDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:03:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9370 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422704AbWGJRDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:03:15 -0400
Message-ID: <44B28834.4060302@torque.net>
Date: Mon, 10 Jul 2006 13:02:44 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, tomfa@debian.org, kumba@gentoo.org
Subject: [ANNOUNCE] sdparm 0.99
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdparm is a command line utility designed to get and set
SCSI device parameters (cf hdparm for ATA disks). The
parameters are held in mode pages. Apart from SCSI devices
(e.g. disks, tapes and enclosures) sdparm can be used on
any device that uses a SCSI command set. Virtually all CD/DVD
drives use the SCSI MMC set irrespective of the transport.
sdparm also can decode VPD pages including the device
identification page. Commands to start and stop the media;
load and unload removable media and some other housekeeping
functions are supported. sdparm supports both the lk 2.4 and
2.6 series.

This version fixes a problem that appeared in version 0.98:
A Request Sense command was added to clear down any pending
Unit Attention conditions but libata doesn't support
Request Sense. This version expands the exit status values
which are the same as those found in the recently released
sg3_utils version 1.21 .

For more information and downloads see:
http://www.torque.net/sg/sdparm.html

Changelog:
http://www.torque.net/sg/p/sdparm.ChangeLog

Doug Gilbert
