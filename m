Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVDSFm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVDSFm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 01:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVDSFm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 01:42:56 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:35845 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261326AbVDSFmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 01:42:55 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Whirlpool oopses in 2.6.11 and 2.6.12-rc2
Date: Tue, 19 Apr 2005 08:42:10 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504190842.10991.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modprobe tcrypt hangs the box on both kernels.
The last printks are:

<wp256 test runs ok>

testing wp384
NN<n>Unable to handle kernel paging request at virtual address eXXXXXXX

Nothing is printed after this and system locks up solid.
No Sysrq-B.

IIRC, 2.6.9 was okay.

Just a heads-up.
--
vda

