Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUAGBQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 20:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266111AbUAGBQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 20:16:48 -0500
Received: from brian.cwazy.net ([69.10.134.66]:62592 "EHLO brian.cwazy.net")
	by vger.kernel.org with ESMTP id S266110AbUAGBQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 20:16:46 -0500
Message-ID: <1163.68.99.220.166.1073438223.squirrel@newsite.cwazy.net>
Date: Wed, 7 Jan 2004 01:17:03 -0000 (GMT)
Subject: checking the calling eip of a system call
From: "jnf" <jnf@redwhitearmy.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A friend of mine wrote some kernel code that without getting too much into
how exactly the code works, checks the calling eip of a system call and
just verifies that its not coming from 'bad' areas, bad areas being
defined as the stack/heap/data/bss, While I realize this hardly fixes a
possible buffer overflow (this wouldnt affect a return into libc type
exploit for instance). He recently asked me to take a look at it and give
him my opinion to see if he should further development in it. So really my
question is, assuming the impletemention of it is good- what problems
could this present to the kernel itself? It seems like a decent basic
sanity check - but there is nothing like it (AFAIK) in the kernel already.
So as I said, what problems could this present, other than breaking self
modifying code and the likes?

thanks,
jnf
