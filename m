Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268585AbTBZBzM>; Tue, 25 Feb 2003 20:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268586AbTBZBzM>; Tue, 25 Feb 2003 20:55:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:46992 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268585AbTBZBzL>; Tue, 25 Feb 2003 20:55:11 -0500
Date: Tue, 25 Feb 2003 17:55:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 407] New: Keyboard glitch detected, ignoring keypress 
Message-ID: <9830000.1046224504@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=407

           Summary: Keyboard glitch detected, ignoring keypress
    Kernel Version: 2.5.62-ac1
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: storri@sbcglobal.net


Distribution: RedHat beta (Phoebe)
Hardware Environment: Intel
Software Environment: 
Problem Description: I am getting the keyboard glitch detected, ignoring
keypress message every few seconds when I boot into kernel 2.5.62-ac1. 

Steps to reproduce:

1) Built kernel-2.5.62-ac1 (patched 2.5.16 with ac patch)
2) Installed and rebooted machine.
3) Problem will start appearing as the user logs in.


Kernel config: (Not sure what else is required)

# 
# Input Device Drivers
# 
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set


