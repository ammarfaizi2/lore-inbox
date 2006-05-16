Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWEPMzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWEPMzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWEPMzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:55:10 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:267 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751814AbWEPMzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:55:09 -0400
Date: Tue, 16 May 2006 14:55:17 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060516145517.2c2d4fe4.khali@linux-fr.org>
In-Reply-To: <20060516103930.0c0d5d33.khali@linux-fr.org>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
	<20060515115302.5abe7e7e.akpm@osdl.org>
	<6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
	<20060515122613.32661c02.akpm@osdl.org>
	<6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com>
	<20060516103930.0c0d5d33.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting myself:

> I'll try to reproduce the bug here.

I can reproduce it, with both i2c-i801 and i2c-parport, so it's not
related to a specific driver. I'm currently performing a bisection on
2.6.17-rc4-mm1 to try and isolate the culprit. It seems to point to
gregkh-driver-*. i2c patches are innocent for sure, including Kumar's
ones.

-- 
Jean Delvare
