Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266792AbUGVCpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266792AbUGVCpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUGVCpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:45:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:44968 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266792AbUGVCpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:45:07 -0400
Subject: pci_bus_lock question
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <gregkh@us.ibm.com>
Cc: Mike Wortman <wortman@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1090447841.544.7.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 21 Jul 2004 17:10:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the intended purpose of pci_bus_lock to synchronize access to _just_
the global list of pci devices, or also to the pci_root_buses list?

If it is intended to protect the latter, I see many unfortunate places
where it's not being used :)

Thanks-
John

