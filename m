Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031435AbWKUVR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031435AbWKUVR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031434AbWKUVR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:17:28 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:62174 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031431AbWKUVR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:17:27 -0500
Message-ID: <45636CDE.8020603@garzik.org>
Date: Tue, 21 Nov 2006 16:17:18 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, htejun@gmail.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sata_promise updates
References: <200611212057.kALKvL8n009798@harpo.it.uu.se>
In-Reply-To: <200611212057.kALKvL8n009798@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And......  is there any chance you could be talked into working on these 
sata_promise to-dos:

* conversion to new error handling system (grep for 'freeze', 'thaw', 
'error_handler', replaces 'phy_reset' and 'eng_timeout')

* support for ATAPI devices (just need to set up ATAPI commands via the 
packet format described in the public docs)

* support for command queueing

Command queueing is the most involved task, the others should be 
reasonably straightforward.

Cheers!

	Jeff




