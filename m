Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbUABV3b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbUABV3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:29:31 -0500
Received: from pengo.systems.pipex.net ([62.241.160.193]:58542 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S265648AbUABV33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:29:29 -0500
From: Shaheed <srhaque@iee.org>
To: linux-kernel@vger.kernel.org
Subject: How to structure a driver for a IDE controller with hardware RAID support?
Date: Fri, 2 Jan 2004 21:31:21 +0000
User-Agent: KMail/1.5.94
References: <200401011659.35973.srhaque@iee.org>
In-Reply-To: <200401011659.35973.srhaque@iee.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401022131.22257.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a device called an IT8212 IDE RAID controller. It comes with a Linux 
2.4 driver which emulates a SCSI interface and supports both JBOD and 
hardware RAID (0 and 1) modes of operation.

I don't quite understand the relationship between drivers/ide/... and RAID 
support. Why for example, would the existing driver be written as a SCSI 
driver and not an IDE driver?

Thanks, Shaheed
