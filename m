Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTDDQlo (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 11:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbTDDQlQ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 11:41:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:17823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263831AbTDDQcp convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 11:32:45 -0500
Date: Fri, 4 Apr 2003 08:44:09 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, steve.cameron@hp.com
Subject: Re: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Message-Id: <20030404084409.7d04dc46.rddunlap@osdl.org>
In-Reply-To: <20030404075652.GA13651@wohnheim.fh-wedel.de>
References: <20030403120308.620e5a14.rddunlap@osdl.org>
	<20030404003044.GB16832@wohnheim.fh-wedel.de>
	<20030403173352.0311312a.rddunlap@osdl.org>
	<20030404075652.GA13651@wohnheim.fh-wedel.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003 09:56:52 +0200 Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

| On Thu, 3 April 2003 17:33:52 +0000, Randy.Dunlap wrote:
| > 
| > | > +		error = copy_to_user(io, my_io, sizeof(*my_io)) ? -EFAULT : 0;
| > | 
| > | copy_to_user returns the bytes successfully copied.
| > | error is set to -EFAULT, if there was actually data transferred?
| > 
| > Did you verify that?
| 
| Yes, but I do make mistakes. Better double-check it yourself.

Oh, I did.  That's why I am asking you.

--
~Randy
