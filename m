Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTKYRRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKYRRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:17:19 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:45734 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262331AbTKYRRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:17:03 -0500
Message-ID: <3FC38E85.1020100@backtobasicsmgmt.com>
Date: Tue, 25 Nov 2003 10:16:53 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kevin Corry <kevcorry@us.ibm.com>
CC: Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <3FC387A0.8010600@backtobasicsmgmt.com> <200311251109.07831.kevcorry@us.ibm.com>
In-Reply-To: <200311251109.07831.kevcorry@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry wrote:

  	---help---
-	  Recent tools use a new version of the ioctl interface, only
-          select this option if you intend using such tools.
+	  Recent tools use this new version of the ioctl interface. Only
+	  select N for this option if you use out-of-date tools that weren't
+	  compiled for this interface (e.g. LVM2 prior to v2.00.00).

Actually, I don't think LVM2 uses the device mapper ioctls at all; it 
use libdevmapper which calls the ioctls on its behalf.

