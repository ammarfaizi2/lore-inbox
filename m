Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269100AbUIXT5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbUIXT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269101AbUIXT5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:57:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14514 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269100AbUIXT5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:57:22 -0400
Message-ID: <41547C16.4070301@pobox.com>
Date: Fri, 24 Sep 2004 15:57:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: mlock(1)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How feasible is it to create an mlock(1) utility, that would allow 
priveleged users to execute a daemon such that none of the memory the 
daemon allocates will ever be swapped out?

ntp daemon does mlock(2) internally, for example, but IMHO this is 
really a policy decision that could be moved out of the app.

Unfortunately I am VM-ignorant as always ;-)

	Jeff



