Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVLPWYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVLPWYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVLPWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:24:10 -0500
Received: from main.gmane.org ([80.91.229.2]:28621 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932529AbVLPWYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:24:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: gtkpod and Filesystem
Followup-To: gmane.linux.kernel
Date: Fri, 16 Dec 2005 23:20:30 +0100
Message-ID: <dnveja$i7i$1@sea.gmane.org>
References: <20051216145234.M78009@linuxwireless.org> <dnul89$r4k$1@sea.gmane.org> <Pine.LNX.4.61.0512162311180.24996@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.117.85.179
User-Agent: KNode/0.10
Cc: debian-devel@lists.debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> a bug in gtkpod or the kernel (FS Panic).
>>Maybe an FS error on your iPod? Did you try to reformat or dosfsck it?
> Even then, the filesystem code should handle corrupt filesystems more
> gracefully.

Mh, what's "more gracefully" in the light of fs corruption? The driver just
blocked write access to avoid further damage caused by writing to an
inconsistent file system which sound perfectly reasonable to me. Writing to
a corrupted fs could cause anything to it, depending on the corruption, so
better act safe than sorry...

Greetings,

  Gunter

