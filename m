Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVJUTOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVJUTOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 15:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVJUTOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 15:14:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3511 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965102AbVJUTOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 15:14:23 -0400
Message-ID: <43593E0A.4070801@pobox.com>
Date: Fri, 21 Oct 2005 15:14:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Merging ATA passthru
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.5 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Folks, Taking Mark Lord's (and others) criticism to
	heart, I'm going to merge the ATA passthru work upstream, once 2.6.14
	is released. Since there are still some reported problems that I
	haven't had time to track down, I'm going to -- like ATAPI -- introduce
	a module option that enables passthru. It will default to off. [...] 
	Content analysis details:   (0.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Folks,

Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
the ATA passthru work upstream, once 2.6.14 is released.

Since there are still some reported problems that I haven't had time to 
track down, I'm going to -- like ATAPI -- introduce a module option that 
enables passthru.  It will default to off.

Other features that follow a similar pattern -- 98% there but needs a 
few final tweaks -- will be treated in the same way.

This gets lesser-used features upstream where they can get the most 
testing, while defaulting them to off ensures that we won't perturb the 
known-working code.

This also will help me, in that I won't have to maintain a bunch of 
parallel codebases.

	Jeff



