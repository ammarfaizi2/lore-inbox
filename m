Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTLXWW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTLXWW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:22:58 -0500
Received: from falka.mfa.kfki.hu ([148.6.72.6]:37509 "EHLO falka.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id S263963AbTLXWW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:22:57 -0500
Date: Wed, 24 Dec 2003 23:22:17 +0100
From: Gergely Tamas <dice@mfa.kfki.hu>
To: Keith Lea <keith@cs.oswego.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 data loss
Message-ID: <20031224222217.GA3408@mfa.kfki.hu>
References: <3FEA0C3C.9090601@cs.oswego.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEA0C3C.9090601@cs.oswego.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been hit by the same problem but using 2.6.0 . As you described,
garbage in files (eg. /etc/modules.conf, ...).

2.6.0, Slackware 9.1

 > The corruption happened on two separate partitions on a single IDE 
 > laptop drive, and both were ReiserFS 3.6 partitions. I don't know if 
 > this is a kernel bug or a Reiser bug or something else, but I thought 

I don't think this is a reiserfs bug. This was my first thought and
after first hitting this bug, I've moved all my partitions from reiserfs
to jfs. But I've also had this problem with it... Now I'm back to
2.4.23, and everything works fine.

Gergely
