Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUFAHcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUFAHcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 03:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbUFAHcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 03:32:21 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:42374
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S264916AbUFAHcT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 03:32:19 -0400
Message-Id: <200406010732.i517WHOm009984@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Intel 875 Motherboard cant use 4GB of Memory.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Jun 2004 01:32:17 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two questons really:

The BIOS of a Motherboard reports how much memory is available to a 
user program (Linux) after reserving some memory 'for its own use'

What is this memory reserved for?

OK, now the subject of this note.
The Intel D875PZB motherboard has an error in its current BIOS.

With a single 1GB stick of memory inserted, it reserves 38MB		 	    (agan my 
question: what for?) leaving most of the 1GB for the user.
With two 1GB sticks of memory inserted, it reserves 72MB
    leaving the user most of the 2GB.

BUT with 4 1GB stick of memory inserted, it reserves 1.46GB
    which has to be an arithmetic error, leaving the user only 2.6 or so.

So, my second question.
Is this space just 'gone' until (if?) INTEL fixes the BIOS, or is
there some way for Linux to 'get it back'.

I have a certain fear of setting 'mem=' not knowing what this
space is being used for...

-- 
                                        Reg.Clemens
                                        reg@dwf.com


