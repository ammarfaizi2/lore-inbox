Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWGKTVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWGKTVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWGKTVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:21:51 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:37043 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751187AbWGKTVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:21:50 -0400
Subject: core-iscsi-dv.sh and Core-iSCSI-tools v3.5 released!
From: "Nicholas A. Bellinger" <nab@kernel.org>
To: Core-iSCSI <Core-iSCSI@googlegroups.com>
Cc: iet-dev <iscsitarget-devel@lists.sourceforge.net>,
       Open iSCSI <open-iscsi@googlegroups.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 12:12:32 -0700
Message-Id: <1152645152.4955.0.camel@haakon>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

Core-iSCSI-tools v3.5 has been released:

http://www.kernel.org/pub/linux/utils/storage/iscsi/core-iscsi-tools-v3.5.tar.bz2

The core-iscsi-dv.sh domain validation script has been released at:

http://www.linux-iscsi.org/index.php/Core-iscsi-dv

Note that this script is primarly oriented for iSCSI vendors and
developers for testing data IO using a CLI program accepting a block
device as an arguement.  This tool will be run a pre-calculated number
of times each time negotiating a different set of RFC-3720 parameter
keys until the configuration space has been exhausted.

Currently, v1.0 uses a simple dd_read() to read a few sectors from the
iSCSI CHANNEL+LUN blockdevice that is passed as arguements into the
script.  This script can be easily modified for new script routines that
call any of the large number of available data integrity tools.  Futher
integration of publically available test tools is something that will be
ongoing for the core-iscsi-dv project.

For limitations, warnings and general usage please refer to README:

http://www.linux-iscsi.org/files/core-iscsi-dv/README

Thanks,

-- 
Nicholas A. Bellinger <nab@kernel.org>

