Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVCICJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVCICJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVCICAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:00:40 -0500
Received: from nonada.if.usp.br ([143.107.131.169]:12721 "EHLO
	nonada.if.usp.br") by vger.kernel.org with ESMTP id S262316AbVCIB4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:56:39 -0500
From: =?iso-8859-1?q?Jo=E3o_Luis_Meloni_Assirati?= 
	<assirati@nonada.if.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Pktcdvd and DVD RW drive.
Date: Tue, 8 Mar 2005 22:56:34 -0300
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503082256.34965.assirati@nonada.if.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an

 hdc: HL-DT-ST DVDRAM GSA-4120B, ATAPI CD/DVD-ROM drive

from LG. My kernel is a vanilla 2.6.11 with packet writing enabled. I noticed, 
however, that I can mount and write a CD-RW udf formatted with 

# cdrwtool -d /dev/hdc -q

without the need of the pktcdvd driver (with the module unloaded, indeed), 
simply with

# mount -t udf /dev/hdc /mnt

I thought that this was a property only of DVD+RW and DVDRAM media. Am I 
missing something here? What is then the use of pktcdvd driver?

Thanks in advice,
Joao Luis M. Assirati.
