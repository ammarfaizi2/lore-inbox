Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTBPQEu>; Sun, 16 Feb 2003 11:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbTBPQEu>; Sun, 16 Feb 2003 11:04:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:38791 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267190AbTBPQEn>; Sun, 16 Feb 2003 11:04:43 -0500
Date: Sun, 16 Feb 2003 08:14:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 367] New: modules fail to resolve illegal Unhandled relocation of type 10 for .text 
Message-ID: <15960000.1045412073@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=367

           Summary: modules fail to resolve illegal Unhandled relocation of
                    type 10 for .text
    Kernel Version: 2.5.60
            Status: NEW
          Severity: blocking
             Owner: rth@twiddle.net
         Submitter: donaldlf@i-55.com


Distribution: redhat/rawhide
Hardware Environment:LX164
Software Environment: rawhide
Problem Description:

When an kernel build gets to the make modules section it runs
an depmod. The depmod fails. see below for the error message. 
I'm not quite sure what to do to fix this.

Steps to reproduce:


issue an "make modules_install"

depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: depmod obj_relocate failed

depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text


