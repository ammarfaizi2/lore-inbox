Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbTACKxH>; Fri, 3 Jan 2003 05:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTACKxH>; Fri, 3 Jan 2003 05:53:07 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:26640 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S267487AbTACKxG>;
	Fri, 3 Jan 2003 05:53:06 -0500
Message-ID: <3E156D61.2040105@walrond.org>
Date: Fri, 03 Jan 2003 11:00:49 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: menuconfig Bug in 2.5.54
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst trying to find out why 53/54 is not detecting everything on my 
pci bus (See my previous mails e1000 not detected and pci problems) I 
found a problem with menuconfig

In the PCI Bus section, setting the pci access method to BIOS or direct 
does not get saved on exit. It always defaults back to "Any" on next 
make menuconfig

My problem regarding an incomplete pci bus scan is also still 
outstanding; Any help or suggestions where to look in the code would be 
apprieciated.

Andrew

