Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265895AbUACCbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 21:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbUACCbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 21:31:21 -0500
Received: from brian.cwazy.net ([69.10.134.66]:10126 "EHLO brian.cwazy.net")
	by vger.kernel.org with ESMTP id S265895AbUACCbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 21:31:20 -0500
Message-ID: <1100.68.99.220.166.1073097089.squirrel@newsite.cwazy.net>
Date: Sat, 3 Jan 2004 02:31:29 -0000 (GMT)
Subject: dev_add_pack() & calling functions that can sleep
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

I've been mucking around in my network stack some as of late, trying to
get a feel for how it works, etc. I've just about got the hang of it, but
I am having an issue in one area.

Now as I understand it, when i add a callback routine via dev_add_pack,
that callback routine gets called in an interupt context and thus i cannot
call any functions that sleep. Is there any way around this? I'm wanting
after my callback routine has been called, as it finishes to call a
function that has parts that can in fact sleep. But because of the
contexts of everything I cannot figure a way to do this. Any help would be
appreciated.


cheers,
jnf
