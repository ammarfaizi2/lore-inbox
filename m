Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbTHVUln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 16:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTHVUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 16:41:43 -0400
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:61124
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S263625AbTHVUl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 16:41:29 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Fri, 22 Aug 2003 13:43:16 -0700
MIME-Version: 1.0
Subject: Kernel module symbol versioning?
Message-ID: <3F461DF4.26519.490C74E@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been reading the book "Linux Device Drivers, 2nd Edition" and have 
some questions about symbol versioning. In Chapter 11 it mentions that 
you can use the <linux/modversions.h> header file to compile your module 
with symbol versions enabled, so that your module will load on multiple 
kernels and fail if the symbol CRC's do not match. I tested this out on a 
simple test module, but this module fails to load unless I pass the '-f' 
flag to insmod (Red Hat 7.3 and 8.0). 

Is there a way to compile the module so that insmod will only complain if 
there is a version conflict? Or do you always have to use -f in this case 
to force the module to load? If you have to do that, will -f still fail 
to load if the versioned symbols don't match?

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

