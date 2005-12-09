Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVLIX4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVLIX4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 18:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVLIX4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 18:56:15 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:46518 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932430AbVLIX4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 18:56:14 -0500
Subject: Core-iSCSI v1.6.2.2 (STABLE) + Tools v3.1
From: "Nicholas A. Bellinger" <nab@kernel.org>
To: Core-iSCSI <Core-iSCSI@googlegroups.com>,
       Open iSCSI <open-iscsi@googlegroups.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 15:50:11 -0800
Message-Id: <1134172211.5350.29.camel@haakon>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

Core-iSCSI v1.6.2.2 and Core-iSCSI-tools v3.1 will be available shortly
from:

http://www.kernel.org/pub/linux/kernel/people/nab/iscsi-initiator-core/core-iscsi-v1.6.2.2.tar.bz2
http://www.kernel.org/pub/linux/utils/storage/iscsi/core-iscsi-tools-v3.1.tar.bz2

This release would not have been possible without the help of:

http://www.sbei.com
Dominik and Dustin @ VBI
Daniel @ JHAPL
Bill and Chris @ Wasabi
Albert Pauw
Mike Mazarick
Micky Mazarick
Mark Tyler
jonas@wehey.com

This release includes a solution for single portal + multiple IQN names
that some iSCSI target nodes use as their primary naming scheme.  This
done via an optional parameter inside of the /etc/sysconfig/initiator
which does not break backwards comptability with existing installations.
Additionally a fix has been included for HP iSCSI Target Nodes that
involves the removal of a 'return on error' condition related to
Underflow + S_BIT checking.  For the former, manual pages and howto have
been updated to reflect the change to the /etc/sysconfig/initiator
configuration file.

Additionally, it was recently brought to my attention that a check
related to DataSequeceInOrder=Yes located in iscsi_initiator_erl0.c is
causing a problem with certain vendors iSCSI Target nodes.  I will be
getting more information on this issue in the next few days,  and will
release a fix as soon as possible.  I will keep everyone posted.

Also, the Core-iSCSI list has been created.  Everyone is invited to join
at:  http://groups.google.com/group/Core-iSCSI

And finally, the project's website should be going online sometime in
the next week.  I will keep everyone posted.  We have definately made an
amazing amount of progress in the last 8 days, and the Core-iSCSI team
will keep moving full steam ahead with the project as long as a need
exists.

Thanks for your support.

-- 
Nicholas A. Bellinger <nab@kernel.org>

