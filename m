Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWJMQM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWJMQM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWJMQMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:12:55 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:60139 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751649AbWJMQMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:12:55 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CFCBEB88-B9C0-43DA-B69D-1DDB59926946@kernel.crashing.org>
Cc: Greg KH <gregkh@suse.de>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: constants vs #define for PCI_DEVICE_/PCI_VENDOR_
Date: Fri, 13 Oct 2006 11:13:01 -0500
To: "linux-kernel@vger.kernel.org mailing list" 
	<linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.752.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember some discussion back and forth about the use of constants  
in pci_device_id entries versus defining new PCI_DEVICE_foo/ 
PCI_VENDOR_foo defines.  What is the current coding style of choice  
if the vendor & device id's dont exit in pci_ids.h?

- kumar 
