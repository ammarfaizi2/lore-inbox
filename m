Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbTIASTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTIASTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:19:46 -0400
Received: from main.gmane.org ([80.91.224.249]:43465 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263395AbTIASTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:19:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stephane LOEUILLET <news@leroutier.net>
Subject: 70+ typos in 2.4.22 + script to generate diffs
Date: Mon, 01 Sep 2003 20:15:30 +0200
Message-ID: <pan.2003.09.01.18.15.22.368626@leroutier.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i know, typos aren't really what real programers are looking to fix first
but if those aren't fixed, they would be reported ever and ever and ever
...

so, as i did not know what to do today, i started looking for a few common
typos and found around  70 different ones over the 2.4.22 tree. (some only
written once, others written several times)

as tracking typo is borring, i started to write a perl script that would :

- copy all files containing a know typo (from a separate file) from your
local linux tree (parameter : $KERNEL_SOURCE_ROOT) to a local directory
(parameter : $LOCAL_DIFF_DIR)

- replace all typo by its correct spelling for all know world

It's up to you to merge the diffs after the process is complete (around 1min
for 74 different typos scanning complete 2.4.22 with a Athl2600+)

The script : http://www.leroutier.net/kernel-typo-diffmaker.pl.txt
The typo list : http://www.leroutier.net/typos.base

(put them in the same dir)

then, look at the script (to see it won't "rm -fR / ; kill -9 0")
rename .pl.txt file to .pl then chmod 755 on it
edit both $KERNEL_SOURCE_ROOT and $LOCAL_DIFF_DIR to match your needs
then again, ./kernel-typo-diffmaker.pl

$KERNEL_SOURCE_ROOT could be either your local kernel source dir or one of
its sub-dirs (ex : /usr/src/linux-2.4.22/fs/ufs/)

if you find it useful, use it. if not, sorry.

Stephane LOEUILLET


