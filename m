Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTKSUwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 15:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTKSUwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 15:52:11 -0500
Received: from mhub-m5.tc.umn.edu ([160.94.23.35]:2044 "EHLO
	mhub-m5.tc.umn.edu") by vger.kernel.org with ESMTP id S263937AbTKSUwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 15:52:10 -0500
Subject: Re: menuconfig Error 1
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Paul Nielsen <pnielsenz@cs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FBBC28B.2010006@cs.com>
References: <3FBBC28B.2010006@cs.com>
Content-Type: text/plain
Message-Id: <1069275122.8807.23.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 19 Nov 2003 14:52:02 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(mec removed from CC list since I read he doesn't support menuconfig
now.)

On Wed, 2003-11-19 at 13:20, Paul Nielsen wrote:
> When trying to configure the Alsa sound options (select the "Advanced 
> Linux Sound Architecture" and press <enter>,) "make menuconfig" fails 
> with the message
> "Q> scripts/Menuconfig: line 832: MCmenu78: command not found", for both 
> the linux-2.4.22-10mdk and linux-2.4.22-10mdk kernel sources.

This is a known recurring bug in Mandrake's kernel packaging. It's not a
core kernel issue, so this is more appropriate on a Mandrake mailing
list. A quick google search brings up a message from the cooker list
that says this was fixed in -22mdk. You should get that kernel and use
it instead; if it doesn't work, bug Mandrake, since it's their problem.
(ALSA isn't even part of 2.4 mainline.)

Matt

