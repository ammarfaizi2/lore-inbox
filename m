Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbULESVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbULESVK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbULESVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 13:21:10 -0500
Received: from main.gmane.org ([80.91.229.2]:29871 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261326AbULESVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 13:21:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: Booting 2.6.10-rc3
Date: Sun, 05 Dec 2004 18:10:38 +0000
Organization: World Organi[sz]ation Of Broken Dreams
Message-ID: <coviuv$adu$1@sea.gmane.org>
References: <1102256916.29858.210104494@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: apogee.jonmasters.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
In-Reply-To: <1102256916.29858.210104494@webmail.messagingengine.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Cc: kernelnewbies@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anandraj wrote:

> Red Hat nash version 3.5.22 starting 
> mount: error 6 mounting ext3
> pivotroot: pivo_root(/sysroot,/sysroot/initrd) failed : 2
> umount /initrd/proc failed: 2
> Kenel panic - not syncing: No init found. Try Passing init=option to
> kernel.

> Can somebody help me on this !! ??

You need to read the build instructions for a Fedora Core distribution. 
Briefly however, modern distros rely upon an initial RAMdisk which sets 
up various hardware drivers before changing the root filesystem with the 
pivot_root utility and booting the main system proper.

There's probably a missing mkinitrd et al. in there.

Cheers,

Jon.

