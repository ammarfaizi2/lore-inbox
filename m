Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVBSAlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVBSAlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVBSAlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:41:39 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:51765 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261596AbVBSAlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:41:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=mKvvaqB2aZwTJuvQdHWomZyWZ3MhMW7mOpxfI67wPgqVdGzZpKF9nSsNOagShxR/wkeOrOqrZAzkj5erjvM7XLj9oEubPcGmKz2afmMmSAYzkiJkO0l8cLkoDK5chB+wwZGgqgebmx8lSiJzJZ2V2ntH9r3hpsrHc3ggVx0quJk=
Message-ID: <d14685de050218164127828b06@mail.gmail.com>
Date: Sat, 19 Feb 2005 01:41:19 +0100
From: sylvanino b <sylvanino@gmail.com>
Reply-To: sylvanino b <sylvanino@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: I wrote a kernel tool for monitoring / web page
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote a kernel tool for my personnal usage which goal is to keep a
record of recent task preemptions and interruptions that appears under
linux. Although the record is short (a few minutes only), It can help
to analyse scheduling algorithm efficiency and also driver timing
issues. The user can access data from user-space, through proc
filesystem and analyze it with a graphics tool.  Then, since it's also
availlable within KDB, it can give clues and help for debugging.

So far, the tool is not a big deal, but not trivial either. When It is
running, the tool doesn't overload the system. And when it is not
running, it's just transparent.

I did a webpage for it, you can check it out at:
http://membres.lycos.fr/kernelanalyzer/

If you have any comment/critics, don't hesitate to share it
Thanks,

Sylvain
