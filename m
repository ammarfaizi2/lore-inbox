Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUF1Uab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUF1Uab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUF1U3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:29:22 -0400
Received: from mx.laposte.net ([81.255.54.11]:55761 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S265205AbUF1U2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:28:10 -0400
Message-ID: <40E08096.2040204@laposte.net>
Date: Mon, 28 Jun 2004 22:33:26 +0200
From: jlm_devel <jlm_devel@laposte.net>
Reply-To: jlm_devel@laposte.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a1) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [system crash] [swaps] make the filesystem inaccessible and all applications
 that try to access it hangs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
please cc me since I'm not registered
I work on swapd and I found a way to "crash" a filesystem entry with 
operations on swaps :
kernel version 2.6.7

step to reproduce :
make a swap file into one directory
activate it
rm it

now all application trying to access the containing directory will 
hangs..... including the swapd I write.....

best regards
JLM
