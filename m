Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTDUPQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTDUPQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:16:48 -0400
Received: from franka.aracnet.com ([216.99.193.44]:15777 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261323AbTDUPQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:16:42 -0400
Date: Mon, 21 Apr 2003 08:28:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 611] New: keywest driver fails to compile due to i2c interface changes
Message-ID: <26260000.1050938923@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=611

           Summary: keywest driver fails to compile due to i2c interface
                    changes
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: dilinger@voxel.net


Distribution: Debian unstable
Hardware Environment: NewWorld pmac; 7410, altivec supported
Software Environment: gcc version 3.2.3 20030407 (Debian prerelease)
Problem Description: sound/ppc/keywest.c fails to compile due to i2c interface
changes.  i2c_adapter and i2c_client structs (both in i2c.h) have removed the
data and name fields; keywest.c wasn't updated appropriately.

