Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTEMQrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbTEMQqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:46:50 -0400
Received: from franka.aracnet.com ([216.99.193.44]:12220 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262275AbTEMQqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:46:37 -0400
Date: Tue, 13 May 2003 07:45:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 713] New: USB mouse freezes under X 
Message-ID: <29800000.1052837101@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: USB mouse freezes under X
    Kernel Version: 2.5.6[89], 2.5.6[89]-mm
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: bos@serpentine.com
                CC: rjwalsh@durables.org


Distribution: Red Hat 9
Hardware Environment: Intel 82801DB hub, MS Intellimouse Explorer
Software Environment: Vanilla RH9
Problem Description:

When using the mouse under X, it sometimes freezes up, responding to no further
input.  This does not affect keyboard interactions (but I have a PS/2 kbd, not a
USB one).  The problem can be "cured" by switching virtual terminals, or by
killing and restarting X.

Steps to reproduce:

Start X, open a few windows, waggle the mouse with vigour, preferably while
dragging a window around over other windows (though this is not necessary). 
Within a few seconds, the mouse should freeze.

The problem can take hours to manifest itself if the mouse isn't being used
much, but it always happens.

