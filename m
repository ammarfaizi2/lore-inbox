Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVCHNiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVCHNiU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCHNiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:38:20 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:64114 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S262055AbVCHNiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:38:08 -0500
Date: Tue, 8 Mar 2005 13:38:07 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Fusion-MPT much faster as module
Message-ID: <Pine.LNX.4.61.0503081327560.28812@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On a four CPU Opteron compiling the Fusion-MPT as module gives much better
performance when compiling it in, here some bonnie++ results:

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
compiled in  15872M 38366 71  65602  22 18348   4 53276 84  57947   7 905.4   2
module       15872M 51246 96 204914  70 57236  14 59779 96 264171  33 923.0   2

This happens with 2.6.10, 2.6.11 and 2.6.11-bk2. Controller is a
Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI.

Why is there such a large difference?

Holger
-- 
