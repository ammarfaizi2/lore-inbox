Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752648AbWKBV3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbWKBV3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbWKBV3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:29:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752648AbWKBV3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:29:23 -0500
Date: Thu, 2 Nov 2006 13:29:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yu Luming <luming.yu@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch 1/6] video sysfs support: Add dev argument for
 backlight_device_register.
Message-Id: <20061102132905.79a19a51.akpm@osdl.org>
In-Reply-To: <200611042107.53145.luming.yu@gmail.com>
References: <200611042107.53145.luming.yu@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The second patch throws a decent-sized reject against Len's current tree. 
I was going to fix that but I note that the patches have serious whitespace
issues: multiple-spaces are used in many places where hard tabs should be
used.  Please fix all of that up.

Also, there's no overall description of what these patches *do*.  Just a
bunch of one-liners.  But what is the overall end-result?

