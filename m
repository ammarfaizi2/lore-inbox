Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTFFPis (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTFFPir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:38:47 -0400
Received: from 203-195-207-33.now-india.net.in ([203.195.207.33]:22288 "EHLO
	ionicmicro.com") by vger.kernel.org with ESMTP id S261919AbTFFPiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:38:46 -0400
Message-ID: <000901c32c43$57887ee0$010510ac@ravik98>
From: "Ravi Kiran G" <ravik@ionicmicro.com>
To: <linux-kernel@vger.kernel.org>
References: <20030606142951.GB28581@parcelfarce.linux.theplanet.co.uk> <20030606.073103.123970371.davem@redhat.com>
Subject: ipNetToMediaTable
Date: Fri, 6 Jun 2003 21:20:23 +0530
Organization: Ionic Microsystems Pvt. Ltd.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Return-Path: ravik@ionicmicro.com
X-MDRcpt-To: linux-kernel@vger.kernel.org
Reply-To: ravik@ionicmicro.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this is w.r.t. to the ipNetToMediaTable.
i am working on a project which requires me to add an entry to this table
through a UCD SNMP (4.1.2) manager.
i am currently using the foll. command:

snmpset -v 3 -u <my-user-name> -l authnopriv -a MD5 -A <my-key>
<my-agent-ip> .1.3.6.1.2.1.4.22.1.2.3.172.16.5.6 x "00 a0 b0 c0 d0 ef" (some
MAC).

however, this is resulting in an error packet which says:

Error in Packet.
Reason: noCreation

i also tried the v2 version and i get a similar error (SNMPv2: creation not
allowed).

could some one please help me out as to where i am going wrong?

TIA,

ravi kiran.


Note: 
   Unless otherwise noted, the information provided by this mail does not represent the official statements or views of Ionic Microsystems. 
   Privileged/Confidential information may be contained in this message and may be subject to legal privilege. Access to this e-mail by anyone other than the intended is unauthorised. If you are not the intended recipient (or responsible for delivery of the message to such person), you may not use, copy, distribute or deliver this message (or any part of its contents ) to anyone or take any action in reliance on it. In such case, you should destroy this message, and notify us immediately. If you have received this email in error, please notify us immediately by e-mail or telephone and delete the e-mail from any computer.
If you or your employer does not consent to internet e-mail messages of this kind, please notify us immediately. All reasonable precautions have been taken to ensure no viruses are present in this e-mail. As our company cannot accept responsibility for any loss or damage arising from the use of this e-mail or attachments we recommend that you subject these to your virus checking procedures prior to use.


