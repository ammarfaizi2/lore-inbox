Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTKYQsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTKYQsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:48:10 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:20645 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262817AbTKYQsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:48:08 -0500
Message-ID: <3FC387A0.8010600@backtobasicsmgmt.com>
Date: Tue, 25 Nov 2003 09:47:28 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <thornber@sistina.com>
CC: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti>
In-Reply-To: <20031125163313.GD524@reti>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:

> Make the version-4 ioctl interface the default kernel configuration option.
> If you have out of date tools you will need to use the v1 interface.

Actually, isn't the proper way to say this "if your tools are older than 
X and/or were _not_ built against recent 2.6 headers you need to use the 
v1 interface"?

Also, if you're going to change the default you should change the help 
text correspondingly.

