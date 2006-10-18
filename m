Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbWJRPK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWJRPK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbWJRPK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:10:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40352 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161147AbWJRPKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:10:55 -0400
Message-ID: <45364458.7020507@torque.net>
Date: Wed, 18 Oct 2006 11:12:24 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, tomfa@debian.org, kumba@gentoo.org
Subject: [ANNOUNCE] sdparm 1.00
X-Enigmail-Version: 0.94.0.0
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
functions are supported. sdparm supports both the linux
kernel 2.4 and 2.6 series.

This version adds support for vendor specific mode pages.
It modifies some exit status values to be the same as
those found in the recently released sg3_utils version 1.22 .

For more information and downloads see:
http://www.torque.net/sg/sdparm.html

Changelog:
http://www.torque.net/sg/p/sdparm.ChangeLog

A release announcement has been sent to freshmeat.net .

Doug Gilbert
