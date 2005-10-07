Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbVJGP4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbVJGP4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbVJGP4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:56:44 -0400
Received: from zipcon.net ([209.221.136.5]:9933 "HELO zipcon.net")
	by vger.kernel.org with SMTP id S1030442AbVJGP4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:56:43 -0400
Message-ID: <43469A9A.2070104@beezmo.com>
Date: Fri, 07 Oct 2005 08:56:10 -0700
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFClue] pci_get_device, new driver model
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm missing something fundamental, and beg your indulgence.

My current 2.6 drivers support multiple indentical PCI boards.
The init code spins on pci_find_device and assigns instance/minor
numbers as boards are found.  Load script insmods the driver,
gets the major # from /proc/devices, and creates the /dev/ entries.




Not subscribed but lurking,
Bill
-- 
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch

