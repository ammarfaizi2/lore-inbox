Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbTCRPCK>; Tue, 18 Mar 2003 10:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbTCRPCK>; Tue, 18 Mar 2003 10:02:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48556 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262465AbTCRPCI>; Tue, 18 Mar 2003 10:02:08 -0500
Date: Tue, 18 Mar 2003 07:13:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 467] New: DHCPOFFER is ignored at boottime
Message-ID: <12730000.1048000382@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=467

           Summary: DHCPOFFER is ignored at boottime
    Kernel Version: 2.5.65
            Status: NEW
          Severity: high
             Owner: acme@conectiva.com.br
         Submitter: kc0@hotmail.com


Distribution: Debian sid
Hardware Environment: toshiba satellite pro 6100, e100 driver.
Software Environment:
Problem Description:
2.5.64 didn't have this problem using the same .config file.
This is what I see at boottime:
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPREQUEST on eth0 to 255.255.255.255 port 67 interval 3
DHCPOFFER from 192.168.0.1
this is where the kernel should continue booting but instead it goes on with:
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPREQUEST on eth0 to 255.255.255.255 port 67 interval 4
DHCPOFFER from 192.168.0.1
DHCPREQUEST on eth0 to 255.255.255.255 port 67
.
.
.

Steps to reproduce:
compile 2.5.65 and boot


