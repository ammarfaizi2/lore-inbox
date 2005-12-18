Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbVLRTmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbVLRTmD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbVLRTmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:42:03 -0500
Received: from ns1.heckrath.net ([213.239.205.18]:13770 "EHLO
	mail.heckrath.net") by vger.kernel.org with ESMTP id S965250AbVLRTmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:42:01 -0500
Date: Sun, 18 Dec 2005 20:42:53 +0100
From: Sebastian Kaergel <mailing@wodkahexe.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.14.4 [intelfb problem]
Message-Id: <20051218204253.b32a4f61.mailing@wodkahexe.de>
In-Reply-To: <20051215005041.GB4148@kroah.com>
References: <20051215005041.GB4148@kroah.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after installing 2.6.14.4 I'm no longer able to use my intelfb-console.

.config is exactly the same as with 2.6.14.3, but 2.6.14.4 doesn't
switch to fb at all. Just the normal console appears.

dmesg output:
<snip>
intelfb: Video mode must be programmed at boot time.
<snip>

lilo.conf:
vga=791
image=/boot/2.6.14.4-3
 append="video=intelfb"

I don't know, why it isn't working, since nothing intelfb or fb related
changed in this release.

thanks,
sebastian
