Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUIVGXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUIVGXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 02:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUIVGXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 02:23:13 -0400
Received: from web52507.mail.yahoo.com ([206.190.39.132]:35485 "HELO
	web52507.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266613AbUIVGXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 02:23:07 -0400
Message-ID: <20040922062305.52594.qmail@web52507.mail.yahoo.com>
Date: Tue, 21 Sep 2004 23:23:05 -0700 (PDT)
From: Shobhit Mathur <shobhitmmathur@yahoo.com>
Subject: SCSI /proc query ...
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I intend to implement /proc interface for a SCSI HBA.
The proc_info() entry-point in Scsi_Host_Template 
structure automatically takes care of creating a 
proc-dir for each host [HBA] as in :
/proc/scsi/<mydriver>/<HBAnumber>.

I have been able to implement the above stage. Now, I 
am interested in having separate proc-folders for each

SCSI target detected as in :

/proc/scsi/<mydriver>/<HBAnumber1>/<target1>
/proc/scsi/<mydriver>/<HBAnumber1>/<target2>
/proc/scsi/<mydriver>/<HBAnumber1>/<target3> ....

Under each of the target-folders, I would like to
print
relevant information specific to each target.

How do I go about achieving the above objective ? Some
clarifications/insights would be gratifying.

- Thank you

- Shobhit

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
