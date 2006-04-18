Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWDRCZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWDRCZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 22:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDRCZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 22:25:27 -0400
Received: from web5.treasury.qld.gov.au ([203.56.182.50]:9427 "EHLO
	web5.treasury.qld.gov.au") by vger.kernel.org with ESMTP
	id S932084AbWDRCZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 22:25:27 -0400
Subject: No kernel message when filesystem full
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OFC430CAEE.2A513C3F-ON4A257154.000C8284-4A257154.000D5E15@treasury.qld.gov.au>
From: Danny.Weldon@treasury.qld.gov.au
Date: Tue, 18 Apr 2006 12:26:37 +1000
X-MIMETrack: Serialize by Router on 
    SMTP1/Servers/QTreasury(Release 6.5.3FP1|December 15, 2004) at 
    18/04/2006 12:26:01 PM
MIME-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Trs-Check-Ext: web9.treasury.qld.gov.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not getting any kernel messages when a filesystem fills up.  Is this
facility still available or is it now configurable?

# uname -r
2.6.13-15-smp
#
# /sbin/klogd -c 1 -f /tmp/out
#
#
# cat /tmp/out
klogd 1.4.1, log source = /proc/kmsg started.
Inspecting /boot/System.map-2.6.13-15-smp
Loaded 24953 symbols from /boot/System.map-2.6.13-15-smp.
Symbols match kernel version 2.6.13.
No module symbols loaded - kernel modules not enabled.

#
# dd if=/dev/zero of=/opt/xx
dd: writing to `/opt/xx': No space left on device
152449+0 records in
152448+0 records out
78053376 bytes (78 MB) copied, 2.75729 seconds, 28.3 MB/s
#
# tail /tmp/out
klogd 1.4.1, log source = /proc/kmsg started.
Inspecting /boot/System.map-2.6.13-15-smp
Loaded 24953 symbols from /boot/System.map-2.6.13-15-smp.
Symbols match kernel version 2.6.13.
No module symbols loaded - kernel modules not enabled.

#

Please CC any replies to me directly as well.

Regards

Danny Weldon
Technology Officer (Internet & Data Comms)
Information Technology/Queensland Treasury
Ground Floor, 317 Edward Street, Brisbane, QLD, 4000
Phone +617 3405 6581


******************************************************************************************************************************************************

Only an individual or entity who is intended to be a recipient of this e-mail may access or use the information contained in this e-mail or any of its attachments.  Opinions contained in this e-mail or any of its attachments do not necessarily reflect the opinions of Queensland Treasury.

The contents of this e-mail and any attachments are confidential and may be legally privileged and the subject of copyright.  If you have received this e-mail in error, please notify Queensland Treasury immediately and erase all copies of the e-mail and the attachments.  Queensland Treasury uses virus scanning software.  However, it is not liable for viruses present in this e-mail or in any attachment.  

******************************************************************************************************************************************************

