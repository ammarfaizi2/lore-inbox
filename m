Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbTCZSzC>; Wed, 26 Mar 2003 13:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbTCZSzC>; Wed, 26 Mar 2003 13:55:02 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:52410 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261789AbTCZSzB>; Wed, 26 Mar 2003 13:55:01 -0500
Date: Wed, 26 Mar 2003 10:56:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 508] New: typo in ipmi_devintf.c causes kernel compile to fail 
Message-ID: <1441850000.1048704979@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



http://bugme.osdl.org/show_bug.cgi?id=508

           Summary: typo in ipmi_devintf.c causes kernel compile to fail
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: frank@artair.com


Distribution: 
Hardware Environment: intel x86
Software Environment:
Problem Description: drivers/char/ipmi/ipmi_devintf.c:452 'snprinf' should be
'snprintf'

Steps to reproduce: enable ipmi support and try to build kernel.  Adding the
missing 't' fixes the problem

