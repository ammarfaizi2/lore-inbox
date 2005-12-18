Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965305AbVLRX1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbVLRX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 18:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbVLRX1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 18:27:24 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:42956 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S965305AbVLRX1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 18:27:23 -0500
Message-ID: <43A5F058.1060102@tlinx.org>
Date: Sun, 18 Dec 2005 15:27:20 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en, en_US
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unpacked 2.6.13.3 and made it read-only.

Using the "O=" param, built output tree for another machine as
a non-root user.

I wanted to create an installable kernel & module package to copy
to the new machine & install.

I noted new targets:
    binrpm-pkg [& rpm-pkg], and
    tarbz2-pkg [& targz-pkg, & tar-pkg].

Both seem to fail either for reasons that appear to be related to
not honoring the "O=" param, or attempting to actually install into
the root of my build-machine.

Should these targets work or have they not yet been converted to work
within the "O=" framework?  In cases where the Makefile is attempting
to install into "<Root>/boot" or "<Root>/lib/modules" ,should I
expect the output to appear in "$O/boot" and "$O/lib/modules/"?

Please Cc responses to me, in addition to list, thanks.

-linda





