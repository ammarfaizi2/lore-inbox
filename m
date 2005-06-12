Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVFLN2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVFLN2T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVFLN2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:28:18 -0400
Received: from ppp-6-84.mtl.aei.ca ([206.123.6.84]:4846 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262531AbVFLN2Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:28:16 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Armin Schindler <armin@melware.de>
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
Date: Sun, 12 Jun 2005 09:29:02 -0400
User-Agent: KMail/1.7.2
Cc: Greg K-H <greg@kroah.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <11184761113499@kroah.com> <Pine.LNX.4.61.0506121042420.30907@phoenix.one.melware.de>
In-Reply-To: <Pine.LNX.4.61.0506121042420.30907@phoenix.one.melware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200506120929.03212.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 June 2005 04:44, Armin Schindler wrote:
> It didn't follow the development, is devfs now obsolete in kernel?
> If not, these funktions still makes sense.
> 
Armin,

>From Documentation/feature-removal-schedule.txt

What:   devfs
When:   July 2005
Files:  fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
        function calls throughout the kernel tree
Why:    It has been unmaintained for a number of years, has unfixable
        races, contains a naming policy within the kernel that is
        against the LSB, and can be replaced by using udev.
Who:    Greg Kroah-Hartman <greg@kroah.com>

This should not a surprise to anyone...

Ed Tomlinson
