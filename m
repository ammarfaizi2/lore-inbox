Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVCUXCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVCUXCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVCUW7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:59:42 -0500
Received: from bu-ast.bu.edu ([128.197.73.33]:57217 "EHLO bu-ast.bu.edu")
	by vger.kernel.org with ESMTP id S262155AbVCUWzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:55:40 -0500
Message-ID: <37550.128.197.73.126.1111445738.squirrel@128.197.73.126>
Date: Mon, 21 Mar 2005 17:55:38 -0500 (EST)
Subject: LBD/filesystems over 2TB: is it safe?
From: jniehof@bu.edu
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-0.f0.9.1.legacy
X-Mailer: SquirrelMail/1.4.3a-0.f0.9.1.legacy
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone posted to the LBD list last December regarding some supposedly
horrible bugs in large filesystems:
https://www.gelato.unsw.edu.au/archives/lbd/2004-December/000075.html
https://www.gelato.unsw.edu.au/archives/lbd/2004-December/000074.html

(I will admit that these were brought to my attention by that paragon of
fact-checking, a slashdot comment...)

I haven't found anything else online regarding these issues. Our initial
tests seem to indicate that it's possible to fill a 2.5TB ext3 filesystem
without corrupting the data or metadata, and as far as I and my colleagues
can understand the code it doesn't look too bad. But, before I start
loading all our production data up, I'd like to feel confident. Does this
poster know what he's talking about? Is there, or was there, any real
issue?

Running x86-32 using kernel 2.6.8 (from Debian sarge), although can always
roll my own if necessary. Preferred filesystem would be ext3, and I
anticipate no need to grow beyond the initial 2.5TB.
